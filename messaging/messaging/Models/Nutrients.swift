//
//  Nutrients.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/23/22.
//

import Foundation

protocol Nourishment: Codable, Hashable {
    
}

protocol Measured: Codable, Hashable {
    var value: Double   { get set }
    var unit: Unit.Mass { get set }
}

struct Value: Measured {
    var value: Double
    var unit: Unit.Mass
}

protocol NutrientType: Codable, Hashable, Equatable {
    var name: String { get }
    var compound: String { get }
    var unit: Unit.Mass { get }
    
    static func ==(lhs: Self, rhs: Self) -> Bool
}

extension NutrientType {
    var required: Bool { Nutrients.required.contains(nutrient: self) }
    var nqiMultiplier: Double { required ? 1 : -1 }
    static func ==(lhs: Self, rhs: Self) -> Bool { lhs.name == rhs.name }
}

extension Array where Element == any NutrientType {
    func contains(nutrient: any NutrientType) -> Bool {
        self.map{ $0.name }.contains(nutrient.name)
    }
}

protocol Measureable {}

enum Unit {
    enum Mass: Int8, Measureable, Interconvertible, Codable, Hashable {
        case pg = 0
        case ng = 3
        case ug = 6
        case mg = 9
        case gm = 12
        case kg = 15
        
        var description: String {
            switch self {
            case .pg:
                return "pg"
            case .ng:
                return "ng"
            case .ug:
                return "ug"
            case .mg:
                return "mg"
            case .gm:
                return "gm"
            case .kg:
                return "kg"
            }
        }
        
        func conversionExp(from: Unit.Mass, to: Unit.Mass) -> Int8 {
            from.rawValue - to.rawValue
        }
    }
    
    enum Length: Int8, Measureable, Interconvertible, Codable, Hashable {
        case pm = 0
        case ag = 2
        case nm = 3
        case um = 6
        case mm = 9
        case cm = 10
        case m = 12
        case km = 15
        
        func conversionExp(from: Unit.Length, to: Unit.Length) -> Int8 {
            from.rawValue - to.rawValue
        }
    }
    
    enum Volume: Int8, Measureable, Interconvertible, Codable, Hashable {
        case pl = 0
        case nl = 3
        case ul = 6
        case ml = 9
        case cl = 10
        case dl = 11
        case l = 12
        case kl = 15
        
        func conversionExp(from: Unit.Volume, to: Unit.Volume) -> Int8 {
            from.rawValue - to.rawValue
        }
    }
    
    enum Ratio: Interconvertible, Codable, Hashable {
        case density(mass: Mass, volume: Volume)
        
        var logBase: Int8 {
            switch self {
            case .density(let mass, let volume):
                return mass.rawValue - volume.rawValue
            }
        }
        
        func conversionExp(from: Unit.Ratio, to: Unit.Ratio) -> Int8 {
            from.logBase - to.logBase
        }
    }
}

struct Nutrients {
    typealias Grams = Double
    
    enum Kind: String {
        case macro = "Macro"
        case vitamin = "Vitamin"
        case mineral = "Mineral"
        
        var chartTitle: (title: String, subtitle: String) {
            switch self {
            case .macro:
                return ("Macros", "Carbs, Protein, Fat")
            case .vitamin:
                return ("Micros", "Vitamin")
            case .mineral:
                return ("Micros", "Mineral")
            }
        }
        
        var name: String { self.rawValue }
        
        var navigationTitle: String { self.name + " " + "Profile" }
        
        func toggle() -> Kind {
            switch self {
            case .vitamin:
                return .mineral
            case .mineral:
                return .macro
            case .macro:
                return .vitamin
            }
        }
    }
    
    enum Macro: String, CaseIterable, NutrientType {
        case energy = "Energy"
        case water = "Water"
        case carbs = "Carbs"
        case sugar = "Sugar"
        case fiber = "Fiber"
        case fats = "Fats"
        case saturatedFat = "Saturated Fat"
        case transFat = "Trans Fat"
        case cholesterol = "Cholesterol"
        case linoleicAcid = "Linoleic Acid"
        case aLinoleicAcid = "Alpha Linoleic Acid"
        case protein = "Protein"
        
        var name: String {
            switch self {
            case .energy:
                return Constants.Nutrients.Name.energy
            case .sugar:
                return Constants.Nutrients.Name.sugar
            case .water:
                return Constants.Nutrients.Name.water
            case .carbs:
                return Constants.Nutrients.Name.carbs
            case .fiber:
                return Constants.Nutrients.Name.fiber
            case .fats:
                return Constants.Nutrients.Name.fats
            case .saturatedFat:
                return Constants.Nutrients.Name.saturatedFat
            case .transFat:
                return Constants.Nutrients.Name.transFat
            case .cholesterol:
                return Constants.Nutrients.Name.cholesterol
            case .linoleicAcid:
                return Constants.Nutrients.Name.linoleicAcid
            case .aLinoleicAcid:
                return Constants.Nutrients.Name.aLinoleicAcid
            case .protein:
                return Constants.Nutrients.Name.protein
            }
        }
        var unit: Unit.Mass {
            switch self {
            case .water:
                return .kg
            default:
                return .gm
            }
        }
        
        var compound: String { "" }
        
        enum Sugar: Glycemic, CaseIterable, NutrientType {
            case sucrose
            case glucose
            case fructose
            case lactose
            case hfcs
            case honey
            case brown
            case jaggery
            case agave
            case maple
            
            var glycemicIndex: UInt {
                switch self {
                case .glucose: return 100
                default: return 0
                }
            }
            
            var name: String { "" }
            
            var unit: Unit.Mass { .gm }
            
            var compound: String { "" }
        }
        
        enum Carb: CaseIterable, NutrientType {
            enum Rice: CaseIterable {
                case white
                case brown
            }
            
            enum Wheat: CaseIterable {
                case whole
                case processed
            }
            
            case starch
            case rice
            case wheat
            
            var name: String { "" }
            var compound: String { "" }
            var unit: Unit.Mass { .gm }
        }
    }
    
    typealias Micrograms = Double
    typealias Milligrams = Double
    
    enum Micro: CaseIterable {
        enum Vitamin: CaseIterable, NutrientType {
            case a      //(total: Micrograms, retinol: Micrograms? = nil, betaCarotene: Micrograms? = nil)
            case b1     //(thiamin: Milligrams)
            case b2     //(riboflavin: Milligrams)
            case b3     //(niacin: Milligrams)
            case b4     //(choline: Milligrams)
            case b5     //(pantothenicAcid: Milligrams)
            case b6     //(total: Milligrams, pyridoxal: Milligrams? = nil, pyridoxine: Milligrams? = nil, pyridoxamine: Milligrams? = nil)
            case b7     //(biotin: Micrograms)
            case b9     //(folate: Micrograms)
            case b12    //(cobalamin: Micrograms)
            case c      //(ascorbicAcid: Milligrams)
            case d      //(total: Micrograms, cholecalciferol: Micrograms? = nil, ergocalciferol: Micrograms? = nil)
            case e      //(alphaTocopherol: Milligrams)
            case k      //(total: Micrograms, phylloquinone: Micrograms? = nil, menadione: Micrograms? = nil)
            
            var unit: Unit.Mass {
                switch self {
                case .a, .b7, .b9, .b12, .d, .k:
                    return .ug
                case .b1, .b2, .b3, .b4, .b5, .b6, .c, .e:
                    return .mg
                }
            }
            
            var name: String {
                switch self {
                case .a:
                    return Constants.Nutrients.Name.vitaminA
                case .b1:
                    return Constants.Nutrients.Name.vitaminB1
                case .b2:
                    return Constants.Nutrients.Name.vitaminB2
                case .b3:
                    return Constants.Nutrients.Name.vitaminB3
                case .b4:
                    return Constants.Nutrients.Name.vitaminB4
                case .b5:
                    return Constants.Nutrients.Name.vitaminB5
                case .b6:
                    return Constants.Nutrients.Name.vitaminB6
                case .b7:
                    return Constants.Nutrients.Name.vitaminB7
                case.b9:
                    return Constants.Nutrients.Name.vitaminB9
                case .b12:
                    return Constants.Nutrients.Name.vitaminB12
                case .c:
                    return Constants.Nutrients.Name.vitaminC
                case .d:
                    return Constants.Nutrients.Name.vitaminD
                case .e:
                    return Constants.Nutrients.Name.vitaminE
                case .k:
                    return Constants.Nutrients.Name.vitaminK
                }
            }
            
            var compound: String {
                switch self {
                case .a:
                    return Constants.Nutrients.Compound.vitaminA
                case .b1:
                    return Constants.Nutrients.Compound.vitaminB1
                case .b2:
                    return Constants.Nutrients.Compound.vitaminB2
                case .b3:
                    return Constants.Nutrients.Compound.vitaminB3
                case .b4:
                    return Constants.Nutrients.Compound.vitaminB4
                case .b5:
                    return Constants.Nutrients.Compound.vitaminB5
                case .b6:
                    return Constants.Nutrients.Compound.vitaminB6
                case .b7:
                    return Constants.Nutrients.Compound.vitaminB7
                case.b9:
                    return Constants.Nutrients.Compound.vitaminB9
                case .b12:
                    return Constants.Nutrients.Compound.vitaminB12
                case .c:
                    return Constants.Nutrients.Compound.vitaminC
                case .d:
                    return Constants.Nutrients.Compound.vitaminD
                case .e:
                    return Constants.Nutrients.Compound.vitaminE
                case .k:
                    return Constants.Nutrients.Compound.vitaminK
                }
            }
            
            func DRI(nutrient: Nutrients.Micro.Vitamin, gender: Demography.GenderAndLifeStage, group: Demography.AgeGroup) -> Double {
                0
            }
        }
        
        enum Mineral: CaseIterable, NutrientType {
            case Ca
            case Cl
            case Cr
            case Cu
            case F
            case I
            case Fe
            case Mg
            case Mn
            case Mo
            case P
            case K
            case Se
            case Na
            case Zn
            
            var unit: Unit.Mass {
                switch self {
                case .Ca, .F, .Fe, .Mg, .Mn, .P, .Zn, .K, .Na:
                    return .mg
                case .Cr, .Cu, .I, .Mo, .Se:
                    return .ug
                case .Cl:
                    return .gm
                }
            }
            
            var name: String {
                switch self {
                case .Ca:
                    return Constants.Nutrients.Name.calcium
                case .Cl:
                    return Constants.Nutrients.Name.chloride
                case .Cr:
                    return Constants.Nutrients.Name.chromium
                case .Cu:
                    return Constants.Nutrients.Name.copper
                case .F:
                    return Constants.Nutrients.Name.fluoride
                case .Fe:
                    return Constants.Nutrients.Name.iron
                case .Mg:
                    return Constants.Nutrients.Name.magnesium
                case .Mn:
                    return Constants.Nutrients.Name.manganese
                case .Mo:
                    return Constants.Nutrients.Name.molybdenum
                case .P:
                    return Constants.Nutrients.Name.phosphorous
                case .I:
                    return Constants.Nutrients.Name.iodine
                case .K:
                    return Constants.Nutrients.Name.potassium
                case .Se:
                    return Constants.Nutrients.Name.selenium
                case .Na:
                    return Constants.Nutrients.Name.sodium
                case .Zn:
                    return Constants.Nutrients.Name.zinc
                }
            }
            
            var compound: String {
                switch self {
                case .Ca:
                    return Constants.Nutrients.Compound.calcium
                case .Cl:
                    return Constants.Nutrients.Compound.chloride
                case .Cr:
                    return Constants.Nutrients.Compound.chromium
                case .Cu:
                    return Constants.Nutrients.Compound.copper
                case .F:
                    return Constants.Nutrients.Compound.fluoride
                case .I:
                    return Constants.Nutrients.Compound.iodine
                case .Fe:
                    return Constants.Nutrients.Compound.iron
                case .Mg:
                    return Constants.Nutrients.Compound.magnesium
                case .Mn:
                    return Constants.Nutrients.Compound.manganese
                case .Mo:
                    return Constants.Nutrients.Compound.molybdenum
                case .P:
                    return Constants.Nutrients.Compound.phosphorous
                case .K:
                    return Constants.Nutrients.Compound.potassium
                case .Se:
                    return Constants.Nutrients.Compound.selenium
                case .Na:
                    return Constants.Nutrients.Compound.sodium
                case .Zn:
                    return Constants.Nutrients.Compound.zinc
                }
            }
            
            func DRI(nutrient: Nutrients.Micro.Mineral, gender: Demography.GenderAndLifeStage, group: Demography.AgeGroup) -> Double {
                0
            }
        }
    }
    
    static var required: [any NutrientType] {
        Micro.Vitamin.allCases + Micro.Mineral.allCases + [Macro.fiber, Macro.protein, Macro.fats]
    }
    
    static var restricted: [any NutrientType] {
        [Macro.sugar, Macro.carbs, Macro.transFat, Macro.cholesterol, Macro.saturatedFat, Macro.fats, Micro.Mineral.Na]
    }
}

protocol Interconvertible {
    func conversionExp(from: Self, to: Self) -> Int8
}

protocol Glycemic {
    var glycemicIndex: UInt { get }
}

