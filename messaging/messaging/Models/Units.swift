//
//  Units.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation

protocol ExponentInterconvertible {
    func conversionExponent(to: Self) -> Int8
}

protocol Convertible {
    func conversion(to: Self) -> Double
}

protocol UnitType: Convertible, Codable, Hashable {
    var description: String { get }
    func conversionExponent(to: Self) -> Int8
}

extension UnitType {
    func conversion(to: Self) -> Double {
        return pow(10, Double(conversionExponent(to: to)))
    }
}

protocol NutrientUnitType: UnitType, ExponentInterconvertible {}


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
    
    enum Energy: String, NutrientUnitType {
        case kcal = "kcal"
        case cal = "cal"
        
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
        
        func conversionExponent(to: Units.Energy) -> Int8 { return 0 }
    }
    
    enum Mass: Int8, NutrientUnitType {
        case pg = 0
        case ng = 3
        case ug = 6
        case mg = 9
        case gm = 12
        case kg = 15
        
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
        
        func conversionExponent(to: Units.Mass) -> Int8 {
            self.rawValue - to.rawValue
        }
    }
    
    enum Length: Int8, NutrientUnitType {
        case pm = 0
        case ag = 2
        case nm = 3
        case um = 6
        case mm = 9
        case cm = 10
        case m = 12
        case km = 15
        
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
        
        func conversionExponent(to: Units.Length) -> Int8 {
            self.rawValue - to.rawValue
        }
    }
    
    enum Volume: Int8, NutrientUnitType {
        case pl = 0
        case nl = 3
        case ul = 6
        case ml = 9
        case cl = 10
        case dl = 11
        case l = 12
        case kl = 15
        
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
        
        func conversionExponent(to: Units.Volume) -> Int8 {
            self.rawValue - to.rawValue
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
