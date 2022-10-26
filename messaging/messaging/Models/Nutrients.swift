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

protocol NutrientType: Codable, Hashable {
    var name: String { get }
    var compound: String { get }
    var unit: Unit.Mass { get }
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
    
    enum Kind {
        case macro
        case vitamin
        case mineral
    }
    
    enum Macro: String, CaseIterable, NutrientType {
        case energy
        case water
        case carbs
        case sugar
        case fiber
        case fat
        case saturatedFat
        case transFat
        case cholesterol
        case linoleicAcid
        case aLinoleicAcid
        case protein
        
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
            case .fat:
                return Constants.Nutrients.Name.fat
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
            case ca
            case cl
            case cr
            case cu
            case f
            case i
            case fe
            case mg
            case mn
            case mo
            case p
            case k
            case se
            case na
            case zn
            
            var unit: Unit.Mass {
                switch self {
                case .ca, .f, .fe, .mg, .mn, .p, .zn, .k, .na:
                    return .mg
                case .cr, .cu, .i, .mo, .se:
                    return .ug
                case .cl:
                    return .gm
                }
            }
            
            var name: String {
                switch self {
                case .ca:
                    return Constants.Nutrients.Name.calcium
                case .cl:
                    return Constants.Nutrients.Name.chloride
                case .cr:
                    return Constants.Nutrients.Name.chromium
                case .cu:
                    return Constants.Nutrients.Name.copper
                case .f:
                    return Constants.Nutrients.Name.fluoride
                case .fe:
                    return Constants.Nutrients.Name.iron
                case .mg:
                    return Constants.Nutrients.Name.magnesium
                case .mn:
                    return Constants.Nutrients.Name.manganese
                case .mo:
                    return Constants.Nutrients.Name.molybdenum
                case .p:
                    return Constants.Nutrients.Name.phosphorous
                case .i:
                    return Constants.Nutrients.Name.iodine
                case .k:
                    return Constants.Nutrients.Name.potassium
                case .se:
                    return Constants.Nutrients.Name.selenium
                case .na:
                    return Constants.Nutrients.Name.sodium
                case .zn:
                    return Constants.Nutrients.Name.zinc
                }
            }
            
            var compound: String {
                switch self {
                case .ca:
                    return Constants.Nutrients.Compound.calcium
                case .cl:
                    return Constants.Nutrients.Compound.chloride
                case .cr:
                    return Constants.Nutrients.Compound.chromium
                case .cu:
                    return Constants.Nutrients.Compound.copper
                case .f:
                    return Constants.Nutrients.Compound.fluoride
                case .i:
                    return Constants.Nutrients.Compound.iodine
                case .fe:
                    return Constants.Nutrients.Compound.iron
                case .mg:
                    return Constants.Nutrients.Compound.magnesium
                case .mn:
                    return Constants.Nutrients.Compound.manganese
                case .mo:
                    return Constants.Nutrients.Compound.molybdenum
                case .p:
                    return Constants.Nutrients.Compound.phosphorous
                case .k:
                    return Constants.Nutrients.Compound.potassium
                case .se:
                    return Constants.Nutrients.Compound.selenium
                case .na:
                    return Constants.Nutrients.Compound.sodium
                case .zn:
                    return Constants.Nutrients.Compound.zinc
                }
            }
            
            func DRI(nutrient: Nutrients.Micro.Mineral, gender: Demography.GenderAndLifeStage, group: Demography.AgeGroup) -> Double {
                0
            }
        }
    }
}

protocol Interconvertible {
    func conversionExp(from: Self, to: Self) -> Int8
}

protocol Glycemic {
    var glycemicIndex: UInt { get }
}

