//
//  Nutrients.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/23/22.
//

import Foundation
import Collections
import OrderedCollections

protocol Nourishment: Codable, Hashable {
    
}

protocol FDCable: Codable, Hashable {
    var fdcID: Int { get }
}

protocol Measured: Codable, Hashable {
    var value: Double   { get set }
    var unit: Units.Mass { get set }
}

struct Value: Measured {
    var value: Double
    var unit: Units.Mass
}

protocol NutrientType: Comparable, Codable, Hashable, Equatable {
    var name: String { get }
    var compound: String { get }
    var unit: Units.Mass { get }
    var compareKey: Int8 { get }
}

extension NutrientType {
    var required: Bool { Nutrients.required.contains(nutrient: self) }
    var nqiMultiplier: Double { required ? 1 : -1 }
    static func ==(lhs: Self, rhs: Self) -> Bool { lhs.name == rhs.name }
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.compareKey < rhs.compareKey
    }
}

extension Array where Element == any NutrientType {
    func contains(nutrient: any NutrientType) -> Bool {
        self.map{ $0.name }.contains(nutrient.name)
    }
}

protocol Glycemic {
    var glycemicIndex: UInt { get }
}

struct Nutrients {
    typealias Grams = Double
    typealias FDCMap = [Int: any NutrientType]
    
    enum Kind: String {
        case macro = "Macro"
        case vitamin = "Vitamin"
        case mineral = "Mineral"
        
        var chartTitle: (title: String, subtitle: String) {
            switch self {
            case .macro: ("Macros", "Carbs, Protein, Fat")
            case .vitamin: ("Micros", "Vitamin")
            case .mineral: ("Micros", "Mineral")
            }
        }
        
        var name: String { self.rawValue }
        
        var navigationTitle: String { self.name + " " + "Profile" }
        
        func toggle() -> Kind {
            switch self {
            case .vitamin: .mineral
            case .mineral: .macro
            case .macro: .vitamin
            }
        }
    }
    
    static let fdcMap: FDCMap = Dictionary.merge(dicts: [
        Nutrients.Macro.fdcMap,
        Nutrients.Micro.Vitamin.fdcMap,
        Nutrients.Micro.Mineral.fdcMap
    ])
    
    static let fdcMapper: [Nutrients.Kind: FDCMap] = [
        Nutrients.Kind.macro : Nutrients.Macro.fdcMap,
        Nutrients.Kind.vitamin: Nutrients.Micro.Vitamin.fdcMap,
        Nutrients.Kind.mineral: Nutrients.Micro.Mineral.fdcMap
    ]
    
    static var zeroIntakes: NutrientIntakes {
        NutrientIntakes(intakes: [
            .macro : Macro.zeroIntakes,
            .vitamin: Micro.Vitamin.zeroIntakes,
            .mineral: Micro.Mineral.zeroIntakes
        ])
    }
    
    enum Macro: Int8, ComparableHash, CaseIterable, NutrientType, FDCable {
        case energy
        case water
        case carbs
        case sugar
        case fiber
        case fats
        case saturatedFat
        case transFat
        case cholesterol
        case linoleicAcid
        case aLinoleicAcid
        case protein
        
        var compareKey: Int8 { return self.rawValue }
        
        static var zero: OrderedDictionary<Macro, Double> {
            Macro.zeroOrderedDict
        }
        
        static var zeroIntakes: MacroIntakes {
            MacroIntakes(intakes: Macro.zero)
        }
        
        var name: String {
            switch self {
            case .energy:       Constants.Nutrients.Name.energy
            case .sugar:        Constants.Nutrients.Name.sugar
            case .water:        Constants.Nutrients.Name.water
            case .carbs:        Constants.Nutrients.Name.carbs
            case .fiber:        Constants.Nutrients.Name.fiber
            case .fats:         Constants.Nutrients.Name.fats
            case .saturatedFat: Constants.Nutrients.Name.saturatedFat
            case .transFat:     Constants.Nutrients.Name.transFat
            case .cholesterol:  Constants.Nutrients.Name.cholesterol
            case .linoleicAcid: Constants.Nutrients.Name.linoleicAcid
            case .aLinoleicAcid:Constants.Nutrients.Name.aLinoleicAcid
            case .protein:      Constants.Nutrients.Name.protein
            }
        }
        
        var unit: Units.Mass {
            switch self {
            case .water: .kg
            default: .gm
            }
        }
        
        var compound: String { "" }
        
        var fdcID: Int {
            switch self {
            case .protein: 1003
            case .fats: 1004
            case .carbs: 1005
            case .energy: 1008
            case .sugar: 1235
            case .fiber: 2033
            default: -1
            }
        }
        
        static let fdcMap: FDCMap = [
            1003: Nutrients.Macro.protein,
            1004: Nutrients.Macro.fats,
            1005: Nutrients.Macro.carbs,
            1235: Nutrients.Macro.sugar,
            2033: Nutrients.Macro.fiber
        ]
        
        enum Sugar: Int8, ComparableHash, Glycemic, CaseIterable, NutrientType {
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
            
            var compareKey: Int8 { return self.rawValue }
            
            var glycemicIndex: UInt {
                switch self {
                case .glucose: return 100
                default: return 0
                }
            }
            
            var name: String { "" }
            
            var unit: Units.Mass { .gm }
            
            var compound: String { "" }
        }
        
        enum Carb: Int8, CaseIterable, NutrientType {
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
            
            
            var compareKey: Int8 { return self.rawValue }
            var name: String { "" }
            var compound: String { "" }
            var unit: Units.Mass { .gm }
        }
        
        enum Fat: Int8, CaseIterable, NutrientType {
            case sfa
            case mufa
            case pufa
            case trans
            case cholesterol
            
            var compareKey: Int8 { return self.rawValue }
            
            var name: String { "" }
            
            var compound: String { "" }
            
            var unit: Units.Mass { .gm }
            
            var fdcID: Int { 1 }
        }
    }
    
    typealias Micrograms = Double
    typealias Milligrams = Double
    
    enum Micro: CaseIterable {
        enum Vitamin: Int8, ComparableHash, CaseIterable, NutrientType, FDCable {
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
            
            var compareKey: Int8 { return self.rawValue }
            
            static var zero: OrderedDictionary<Vitamin, Double> {
                Vitamin.zeroOrderedDict
            }
            
            static var zeroIntakes: VitaminIntakes {
                VitaminIntakes(intakes: Vitamin.zero)
            }
            
            var unit: Units.Mass {
                switch self {
                case .a, .b7, .b9, .b12, .d, .k:
                    return .ug
                case .b1, .b2, .b3, .b4, .b5, .b6, .c, .e:
                    return .mg
                }
            }
            
            var name: String {
                switch self {
                case .a:    Constants.Nutrients.Name.vitaminA
                case .b1:   Constants.Nutrients.Name.vitaminB1
                case .b2:   Constants.Nutrients.Name.vitaminB2
                case .b3:   Constants.Nutrients.Name.vitaminB3
                case .b4:   Constants.Nutrients.Name.vitaminB4
                case .b5:   Constants.Nutrients.Name.vitaminB5
                case .b6:   Constants.Nutrients.Name.vitaminB6
                case .b7:   Constants.Nutrients.Name.vitaminB7
                case.b9:    Constants.Nutrients.Name.vitaminB9
                case .b12:  Constants.Nutrients.Name.vitaminB12
                case .c:    Constants.Nutrients.Name.vitaminC
                case .d:    Constants.Nutrients.Name.vitaminD
                case .e:    Constants.Nutrients.Name.vitaminE
                case .k:    Constants.Nutrients.Name.vitaminK
                }
            }
            
            var compound: String {
                switch self {
                case .a:    Constants.Nutrients.Compound.vitaminA
                case .b1:   Constants.Nutrients.Compound.vitaminB1
                case .b2:   Constants.Nutrients.Compound.vitaminB2
                case .b3:   Constants.Nutrients.Compound.vitaminB3
                case .b4:   Constants.Nutrients.Compound.vitaminB4
                case .b5:   Constants.Nutrients.Compound.vitaminB5
                case .b6:   Constants.Nutrients.Compound.vitaminB6
                case .b7:   Constants.Nutrients.Compound.vitaminB7
                case.b9:    Constants.Nutrients.Compound.vitaminB9
                case .b12:  Constants.Nutrients.Compound.vitaminB12
                case .c:    Constants.Nutrients.Compound.vitaminC
                case .d:    Constants.Nutrients.Compound.vitaminD
                case .e:    Constants.Nutrients.Compound.vitaminE
                case .k:    Constants.Nutrients.Compound.vitaminK
                }
            }
            
            var fdcID: Int {
                switch self {
                case .a:    1106
                case .c:    1162
                case .d:    1114
                case .e:    1109
                case .k:    1185
                case .b1:   1165
                case .b2:   1166
                case .b3:   1167
                case .b4:   1180
                case .b5:   1170
                case .b6:   1175
                case .b7:   1176
                case .b9:   1177
                case .b12:  1178
                }
            }
            
            static let fdcMap: FDCMap = [
                1106: Nutrients.Micro.Vitamin.a,
                1162: Nutrients.Micro.Vitamin.c,
                1114: Nutrients.Micro.Vitamin.d,
                1109: Nutrients.Micro.Vitamin.e,
                1185: Nutrients.Micro.Vitamin.k,
                1165: Nutrients.Micro.Vitamin.b1,
                1166: Nutrients.Micro.Vitamin.b2,
                1167: Nutrients.Micro.Vitamin.b3,
                1180: Nutrients.Micro.Vitamin.b4,
                1170: Nutrients.Micro.Vitamin.b5,
                1175: Nutrients.Micro.Vitamin.b6,
                1176: Nutrients.Micro.Vitamin.b7,
                1177: Nutrients.Micro.Vitamin.b9,
                1178: Nutrients.Micro.Vitamin.b12
            ]
            
            
            func DRI(nutrient: Nutrients.Micro.Vitamin, gender: Demography.GenderAndLifeStage, group: Demography.AgeGroup) -> Double {
                0
            }
        }
        
        enum Mineral: Int8, ComparableHash, CaseIterable, NutrientType, FDCable {
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
            case S
            case Se
            case Na
            case Zn
            
            var compareKey: Int8 { return self.rawValue }
            
            static var zero: OrderedDictionary<Mineral, Double> {
                Mineral.zeroOrderedDict
            }
            
            static var zeroIntakes: MineralIntakes {
                MineralIntakes(intakes: Mineral.zero)
            }
            
            var unit: Units.Mass {
                switch self {
                case .Ca, .F, .Fe, .Mg, .Mn, .P, .Zn, .K, .Na, .S:
                    return .mg
                case .Cr, .Cu, .I, .Mo, .Se:
                    return .ug
                case .Cl:
                    return .gm
                }
            }
            
            var name: String {
                switch self {
                case .Ca:   Constants.Nutrients.Name.calcium
                case .Cl:   Constants.Nutrients.Name.chloride
                case .Cr:   Constants.Nutrients.Name.chromium
                case .Cu:   Constants.Nutrients.Name.copper
                case .F:    Constants.Nutrients.Name.fluoride
                case .Fe:   Constants.Nutrients.Name.iron
                case .Mg:   Constants.Nutrients.Name.magnesium
                case .Mn:   Constants.Nutrients.Name.manganese
                case .Mo:   Constants.Nutrients.Name.molybdenum
                case .P:    Constants.Nutrients.Name.phosphorous
                case .I:    Constants.Nutrients.Name.iodine
                case .K:    Constants.Nutrients.Name.potassium
                case .S:    Constants.Nutrients.Name.sulfur
                case .Se:   Constants.Nutrients.Name.selenium
                case .Na:   Constants.Nutrients.Name.sodium
                case .Zn:   Constants.Nutrients.Name.zinc
                }
            }
            
            var compound: String {
                switch self {
                case .Ca:   Constants.Nutrients.Compound.calcium
                case .Cl:   Constants.Nutrients.Compound.chloride
                case .Cr:   Constants.Nutrients.Compound.chromium
                case .Cu:   Constants.Nutrients.Compound.copper
                case .F:    Constants.Nutrients.Compound.fluoride
                case .I:    Constants.Nutrients.Compound.iodine
                case .Fe:   Constants.Nutrients.Compound.iron
                case .Mg:   Constants.Nutrients.Compound.magnesium
                case .Mn:   Constants.Nutrients.Compound.manganese
                case .Mo:   Constants.Nutrients.Compound.molybdenum
                case .P:    Constants.Nutrients.Compound.phosphorous
                case .K:    Constants.Nutrients.Compound.potassium
                case .S:    Constants.Nutrients.Compound.sulfur
                case .Se:   Constants.Nutrients.Compound.selenium
                case .Na:   Constants.Nutrients.Compound.sodium
                case .Zn:   Constants.Nutrients.Compound.zinc
                }
            }
            
            var fdcID: Int {
                switch self {
                case .Ca:   1087
                case .Cl:   1088
                case .Fe:   1089
                case .Mg:   1090
                case .P:    1091
                case .K:    1092
                case .Na:   1093
                case .S:    1094
                case .Zn:   1095
                case .Cr:   1096
                case .Cu:   1098
                case .F:    1099
                case .I:    1100
                case .Mn:   1101
                case .Mo:   1102
                case .Se:   1103
                }
            }
            
            static let fdcMap: FDCMap = [
                1087: Nutrients.Micro.Mineral.Ca,
                1088: Nutrients.Micro.Mineral.Cl,
                1089: Nutrients.Micro.Mineral.Fe,
                1090: Nutrients.Micro.Mineral.Mg,
                1091: Nutrients.Micro.Mineral.P,
                1092: Nutrients.Micro.Mineral.K,
                1093: Nutrients.Micro.Mineral.Na,
                1094: Nutrients.Micro.Mineral.S,
                1095: Nutrients.Micro.Mineral.Zn,
                1096: Nutrients.Micro.Mineral.Cr,
                1098: Nutrients.Micro.Mineral.Cu,
                1099: Nutrients.Micro.Mineral.F,
                1100: Nutrients.Micro.Mineral.I,
                1101: Nutrients.Micro.Mineral.Mn,
                1102: Nutrients.Micro.Mineral.Mo,
                1103: Nutrients.Micro.Mineral.Se
            ]
            
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

