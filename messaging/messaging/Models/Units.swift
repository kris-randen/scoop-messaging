//
//  Units.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation

protocol ExponentInterconvertible: Convertible {
    func conversionExponent(to: Self) -> Int8
}

extension ExponentInterconvertible {
    func conversion(to: Self) -> Double {
        pow(10, Double(conversionExponent(to: to)))
    }
}

protocol Convertible {
    func conversion(to: Self) -> Double
}

protocol UnitType: Convertible, Codable, Hashable {
    var description: String { get }
}

protocol ExponentUnitType: UnitType, ExponentInterconvertible {}

protocol NutrientUnitType: ExponentUnitType {}

protocol NutrientUnitEnumOrderedKey: NutrientUnitType, EnumTypeOrderedKey {}

protocol UnitEnumOrderedKey: UnitType, EnumTypeOrderedKey {}

extension NutrientUnitEnumOrderedKey where RawValue == Int8 {
    func conversionExponent(to: Self) -> Int8 {
        self.rawValue - to.rawValue
    }
}


enum Units {
    enum Kind: Int8, EnumTypeOrderedKey {
        case energy
        case mass
        case length
        case volume
        
        var fdcUnits: Set<String> {
            switch self {
            case .energy:   Constants.FDCunits.energy
            case .mass:     Constants.FDCunits.mass
            case .length:   Constants.FDCunits.length
            case .volume:   Constants.FDCunits.volume
            }
        }
        
        static func get(from fdcUnit: String) -> Self? {
            allCases.filter {$0.fdcUnits.contains(fdcUnit)}.first
        }
    }
    
    static let table: [String: any NutrientUnitType] = [
        "g": Units.Mass.gm,
        "mg": Units.Mass.mg,
        "ug": Units.Mass.ug,
        "kg": Units.Mass.kg,
        "kcal": Units.Energy.kcal
    ]
    
    enum Energy: Int8, NutrientUnitEnumOrderedKey {
        case cal = -3
        case kcal = 0
        
        static var table: [String: Units.Energy] = [
            "cal" : .cal,
            "kcal": .kcal
        ]
        
        var description: String {
            switch self {
            case .cal: Constants.Units.Energy.cal
            case .kcal: Constants.Units.Energy.kcal
            }
        }
    }
    
    enum Mass: Int8, NutrientUnitEnumOrderedKey {
        case pg = -12
        case ng = -9
        case ug = -6
        case mg = -3
        case gm = 0
        case kg = 3
        
        static var table: [String: Units.Mass] = [
            "mg"    : .mg,
            "g"     : .gm,
            "kg"    : .kg
        ]
        
        var description: String {
            switch self {
            case .pg: Constants.Units.Mass.pg
            case .ng: Constants.Units.Mass.ng
            case .ug: Constants.Units.Mass.ug
            case .mg: Constants.Units.Mass.mg
            case .gm: Constants.Units.Mass.gm
            case .kg: Constants.Units.Mass.kg
            }
        }
    }
    
    enum Length: Int8, NutrientUnitEnumOrderedKey {
        case pm = -10
        case ag = -8
        case nm = -7
        case um = -4
        case mm = -1
        case cm = 0
        case m = 2
        case km = 5
        
        static var table: [String: Units.Length] = [
            "mm"    : .mm,
            "m"     : .m,
            "km"    : .km
        ]
        
        var description: String {
            switch self {
            case .pm: Constants.Units.Length.pm
            case .ag: Constants.Units.Length.ag
            case .nm: Constants.Units.Length.nm
            case .um: Constants.Units.Length.um
            case .mm: Constants.Units.Length.mm
            case .cm: Constants.Units.Length.cm
            case .m:  Constants.Units.Length.m
            case .km: Constants.Units.Length.km
            }
        }
    }
    
    enum Volume: Int8, NutrientUnitEnumOrderedKey {
        case pl = -9
        case nl = -6
        case ul = -3
        case ml = 0
        case cl = 1
        case dl = 2
        case l = 3
        case kl = 6
        
        static var table: [String: Units.Volume] = [
            "ml" : .ml,
            "dl" : .dl,
            "l"  : .l
        ]
        
        var description: String {
            switch self {
            case .pl: Constants.Units.Volume.pl
            case .nl: Constants.Units.Volume.nl
            case .ul: Constants.Units.Volume.ul
            case .ml: Constants.Units.Volume.ml
            case .cl: Constants.Units.Volume.cl
            case .dl: Constants.Units.Volume.dl
            case .l:  Constants.Units.Volume.l
            case .kl: Constants.Units.Volume.kl
            }
        }
    }
    
    enum Ratio: ExponentInterconvertible, Codable, Hashable {

        case density(mass: Mass, volume: Volume)
        
        var logBase: Int8 {
            switch self {
            case .density(let mass, let volume):
                return mass.rawValue - volume.rawValue
            }
        }
        
        func conversionExponent(to: Units.Ratio) -> Int8 {
            self.logBase - to.logBase
        }
    }
}
