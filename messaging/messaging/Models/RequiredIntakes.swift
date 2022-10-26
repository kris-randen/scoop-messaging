//
//  RequiredIntakes.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/25/22.
//

import Foundation
import Collections
import OrderedCollections

enum Level: CaseIterable, Codable, Equatable {
    case ai
    case ui
    case dv
}

protocol Intakeable {
    associatedtype Nutrient: NutrientType
    var intakes: OrderedDictionary<Nutrient, Double> { get set }
}

protocol Intakeables {
    var intakes: OrderedDictionary<Nutrients.Kind, any Intakeable> { get }
}

struct NutrientIntakes: Intakeables {
    var intakes: OrderedDictionary<Nutrients.Kind, any Intakeable>
}


protocol RequireableIntakes {
    var requiredIntakes: OrderedDictionary<Level, GenderizableIntakes> { get set }
}

protocol GenderizableIntakes {
    var genderIntake: OrderedDictionary<Demography.GenderAndLifeStage, AgeGroupIntakes> { get set }
}

enum NutrientValueType {
    case value
    case nqi
    case nmb
}

enum ServingType {
    case mass
    case volume
    case energy
}

protocol Serveable {
    associatedtype ServingUnit: Measureable
    var unit: ServingUnit { get }
    var value: Double { get }
}

struct VolumeServing: Serveable {
    typealias ServingUnit = Unit.Volume
    var unit: Unit.Volume
    var value: Double
}

struct MassServing: Serveable {
    typealias ServingUnit = Unit.Mass
    var unit: Unit.Mass
    var value: Double
}

protocol NutrientProfileable {
    var description: String { get }
    var type: NutrientValueType { get }
    var intakes: OrderedDictionary<Nutrients.Kind, any Intakeable> { get }
}



protocol ServeableNutrientProfile: NutrientProfileable {
    var serving: any Serveable { get }
}

struct NutrientProfile: NutrientProfileable {
    var description: String
    var type: NutrientValueType
    var intakes: OrderedDictionary<Nutrients.Kind, any Intakeable>
}

struct NutrientProfileServed: ServeableNutrientProfile {
    var serving: any Serveable
    var description: String
    var type: NutrientValueType
    var intakes: OrderedDictionary<Nutrients.Kind, any Intakeable>
}

protocol AgeGroupableIntakes {
    associatedtype Group: Hashable
    var intakes: OrderedDictionary<Group, NutrientIntakes> { get set }
}

struct MacroIntakes: Intakeable {
    typealias Nutrient = Nutrients.Macro
    var intakes: OrderedDictionary<Nutrient, Double>
}

struct VitaminIntakes: Intakeable {
    typealias Nutrient = Nutrients.Micro.Vitamin
    var intakes: OrderedDictionary<Nutrients.Micro.Vitamin, Double>
}

struct MineralIntakes: Intakeable {
    typealias Nutrient = Nutrients.Micro.Mineral
    
    var intakes: OrderedDictionary<Nutrients.Micro.Mineral, Double>
}

struct AgeGroupIntakes: AgeGroupableIntakes {
    typealias Group = Demography.AgeGroup
    var intakes: OrderedDictionary<Demography.AgeGroup, NutrientIntakes>
}

struct GenderIntakes: GenderizableIntakes {
    var genderIntake: OrderedDictionary<Demography.GenderAndLifeStage, AgeGroupIntakes>
}

struct RequiredIntakes: RequireableIntakes {
    var requiredIntakes: OrderedDictionary<Level, GenderizableIntakes>
}


struct Profiles {
    static let profile = NutrientProfile(
        description: "Daily Value",
        type: .value,
        intakes: [
            .vitamin: VitaminIntakes(intakes: [
                .a: 900, .c: 90, .d: 20, .e: 15, .k: 120, .b1: 1.2, .b2: 1.3,
                .b3: 16, .b6: 1.7, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 550
            ]),
            .mineral: MineralIntakes(intakes: [
                .ca: 1300, .cr: 35, .cu: 900, .f: 4, .i: 150, .fe: 18, .mg: 420, .mn: 2.3,
                .mo: 45, .p: 1250, .se: 55, .zn: 11, .k: 4700, .na: 2300, .cl: 2.3
            ]),
            .macro: MacroIntakes(intakes: [
                .water: 3.7, .carbs: 130, .fiber: 38, .linoleicAcid: 17, .aLinoleicAcid: 1.6, .protein: 56
            ])
        ])
    
    static let boostHighProteinDrink = NutrientProfile(
        description: Constants.Food.boostHighProteinDrink,
        type: .nqi,
        intakes: [
            .vitamin: VitaminIntakes(intakes: [
                .a: 1.6, .c: 8, .d: 4.8, .e: 8, .k: 2, .b1: 2, .b2: 3.2,
                .b3: 1.6, .b4: 0.8, .b5: 2, .b6: 2.8, .b7: 4, .b9: 2, .b12: 3.6
            ]),
            .mineral: MineralIntakes(intakes: [
                .ca: 2.4, .cr: 4, .cu: 3.6,.f: 0, .i: 2, .fe: 2, .mg: 2, .mn: 2.8,
                .mo: 2, .p: 2, .se: 2.8, .zn: 3.2, .k: 0.8, .na: 0.8, .cl: 1.2
            ]),
            .macro: MacroIntakes(intakes: [
                .energy: 1, .fat: 0.64, .saturatedFat: 0.4, .cholesterol: 0.24,
                .carbs: 0.8, .fiber: 0, .sugar: 4.4, .protein: 3.2
            ])
        ])
}

struct FoodItemProfiles {
    static let boostHighProteinDrink = "Boost High Protein Drink"
    static let boostVeryHighEnergyDrink = "Boost Very High Energy Drink"
    static let boostMaxMenShake = "Boost Max Men Shake"
}


struct Intakes {
    static let required = RequiredIntakes(
        requiredIntakes: [
            .ai: GenderIntakes(genderIntake: [
                .male : AgeGroupIntakes(
                    intakes: [
                        .baby: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 400, .c: 40, .d: 10, .e: 4, .k: 2, .b1: 0.2, .b2: 0.3,
                                .b3: 2, .b6: 0.1, .b9: 65, .b12: 0.4, .b5: 1.7, .b7: 5, .b4: 125
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 200, .cr: 0.2, .cu: 200, .f: 0.01, .i: 110, .fe: 30, .mg: 30, .mn: 0.003,
                                .mo: 2, .p: 100, .se: 15, .zn: 2, .k: 400, .na: 110, .cl: 0.18
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 0.7, .carbs: 60, .fat: 31, .linoleicAcid: 4.4, .aLinoleicAcid: 0.5, .protein: 9.1
                            ])
                        ]),
                        .infant: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 500, .c: 40, .d: 10, .e: 4, .k: 2, .b1: 0.3, .b2: 0.4,
                                .b3: 4, .b6: 0.3, .b9: 80, .b12: 0.5, .b5: 1.8, .b7: 6, .b4: 150
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 260, .cr: 5.5, .cu: 220, .f: 0.5, .i: 130, .fe: 11, .mg: 75, .mn: 0.6,
                                .mo: 3, .p: 275, .se: 20, .zn: 3, .k: 860, .na: 370, .cl: 0.57
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 0.8, .carbs: 95, .fat: 30, .linoleicAcid: 4.6, .aLinoleicAcid: 0.5, .protein: 11
                            ])
                        ]),
                        .toddler: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 300, .c: 15, .d: 15, .e: 6, .k: 30, .b1: 0.5, .b2: 0.5,
                                .b3: 6, .b6: 0.5, .b9: 150, .b12: 0.9, .b5: 2, .b7: 8, .b4: 200
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 700, .cr: 11, .cu: 340, .f: 0.7, .i: 90, .fe: 7, .mg: 80, .mn: 1.2,
                                .mo: 17, .p: 460, .se: 20, .zn: 3, .k: 2000, .na: 800, .cl: 1.5
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 1.3, .carbs: 130, .fiber: 19, .linoleicAcid: 7, .aLinoleicAcid: 0.7, .protein: 13
                            ])
                        ]),
                        .child: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 400, .c: 25, .d: 15, .e: 7, .k: 55, .b1: 0.6, .b2: 0.6,
                                .b3: 8, .b6: 0.6, .b9: 200, .b12: 1.2, .b5: 3, .b7: 12, .b4: 250
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1000, .cr: 15, .cu: 440, .f: 1, .i: 90, .fe: 10, .mg: 130, .mn: 1.5,
                                .mo: 22, .p: 500, .se: 30, .zn: 5, .k: 2300, .na: 1000, .cl: 1.9
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 1.7, .carbs: 130, .fiber: 25, .linoleicAcid: 10, .aLinoleicAcid: 0.9, .protein: 19
                            ])
                        ]),
                        .preteen: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 600, .c: 45, .d: 15, .e: 11, .k: 60, .b1: 0.9, .b2: 0.9,
                                .b3: 12, .b6: 1, .b9: 300, .b12: 1.8, .b5: 4, .b7: 20, .b4: 375
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1300, .cr: 25, .cu: 700, .f: 2, .i: 120, .fe: 8, .mg: 240, .mn: 1.9,
                                .mo: 34, .p: 1250, .se: 40, .zn: 8, .k: 2500, .na: 1200, .cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 2.4, .carbs: 130, .fiber: 31, .linoleicAcid: 12, .aLinoleicAcid: 1.2, .protein: 34
                            ])
                        ]),
                        .teen: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 900, .c: 75, .d: 15, .e: 15, .k: 75, .b1: 1.2, .b2: 1.3,
                                .b3: 16, .b6: 1.3, .b9: 400, .b12: 2.4, .b5: 5, .b7: 25, .b4: 550
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1300, .cr: 35, .cu: 890, .f: 3, .i: 150, .fe: 11, .mg: 410, .mn: 2.2,
                                .mo: 43, .p: 1250, .se: 55, .zn: 11, .k: 3000, .na: 1500, .cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 3.3, .carbs: 130, .fiber: 38, .linoleicAcid: 16, .aLinoleicAcid: 1.6, .protein: 52
                            ])
                        ]),
                        .adult: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 900, .c: 90, .d: 15, .e: 15, .k: 120, .b1: 1.2, .b2: 1.3,
                                .b3: 16, .b6: 1.3, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 550
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1000, .cr: 35, .cu: 900, .f: 4, .i: 150, .fe: 8, .mg: 400, .mn: 2.3,
                                .mo: 45, .p: 700, .se: 55, .zn: 11, .k: 3400, .na: 1500, .cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 3.7, .carbs: 130, .fiber: 38, .linoleicAcid: 17, .aLinoleicAcid: 1.6, .protein: 56
                            ])
                        ]),
                        .middle: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 900, .c: 90, .d: 15, .e: 15, .k: 120, .b1: 1.2, .b2: 1.3,
                                .b3: 16, .b6: 1.3, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 550
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1000, .cr: 35, .cu: 900, .f: 4, .i: 150, .fe: 8, .mg: 420, .mn: 2.3,
                                .mo: 45, .p: 700, .se: 55, .zn: 11, .k: 3400, .na: 1500, .cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 3.7, .carbs: 130, .fiber: 38, .linoleicAcid: 17, .aLinoleicAcid: 1.6, .protein: 56
                            ])
                        ]),
                        .old: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 900, .c: 90, .d: 15, .e: 15, .k: 120, .b1: 1.2, .b2: 1.3,
                                .b3: 16, .b6: 1.7, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 550
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1000, .cr: 30, .cu: 900, .f: 4, .i: 150, .fe: 8, .mg: 420, .mn: 2.3,
                                .mo: 45, .p: 700, .se: 55, .zn: 11, .k: 3400, .na: 1500, .cl: 2
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 3.7, .carbs: 130, .fiber: 30, .linoleicAcid: 14, .aLinoleicAcid: 1.6, .protein: 56
                            ])
                        ]),
                        .senior: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 900, .c: 90, .d: 20, .e: 15, .k: 120, .b1: 1.2, .b2: 1.3,
                                .b3: 16, .b6: 1.7, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 550
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1200, .cr: 30, .cu: 900, .f: 4, .i: 150, .fe: 8, .mg: 420, .mn: 2.3,
                                .mo: 45, .p: 700, .se: 55, .zn: 11, .k: 3400, .na: 1500, .cl: 1.8
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 3.7, .carbs: 130, .fiber: 30, .linoleicAcid: 14, .aLinoleicAcid: 1.6, .protein: 56
                            ])
                        ])
                    ]),
                .female: AgeGroupIntakes(
                    intakes: [
                        .baby: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 400, .c: 40, .d: 10, .e: 4, .k: 2, .b1: 0.2, .b2: 0.3,
                                .b3: 2, .b6: 0.1, .b9: 65, .b12: 0.4, .b5: 1.7, .b7: 5, .b4: 125
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 200, .cr: 0.2, .cu: 200, .f: 0.01, .i: 110, .fe: 30, .mg: 30, .mn: 0.003,
                                .mo: 2, .p: 100, .se: 15, .zn: 2, .k: 400, .na: 110, .cl: 0.18
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 0.7, .carbs: 60, .fat: 31, .linoleicAcid: 4.4, .aLinoleicAcid: 0.5, .protein: 9.1
                            ])
                        ]),
                        .infant: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 500, .c: 40, .d: 10, .e: 4, .k: 2, .b1: 0.3, .b2: 0.4,
                                .b3: 4, .b6: 0.3, .b9: 80, .b12: 0.5, .b5: 1.8, .b7: 6, .b4: 150
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 260, .cr: 5.5, .cu: 220, .f: 0.5, .i: 130, .fe: 11, .mg: 75, .mn: 0.6,
                                .mo: 3, .p: 275, .se: 20, .zn: 3, .k: 860, .na: 370, .cl: 0.57
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 0.8, .carbs: 95, .fat: 30, .linoleicAcid: 4.6, .aLinoleicAcid: 0.5, .protein: 11
                            ])
                        ]),
                        .toddler: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 300, .c: 15, .d: 15, .e: 6, .k: 30, .b1: 0.5, .b2: 0.5,
                                .b3: 6, .b6: 0.5, .b9: 150, .b12: 0.9, .b5: 2, .b7: 8, .b4: 200
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 700, .cr: 11, .cu: 340, .f: 0.7, .i: 90, .fe: 7, .mg: 80, .mn: 1.2,
                                .mo: 17, .p: 460, .se: 20, .zn: 3, .k: 2000, .na: 800, .cl: 1.5
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 1.3, .carbs: 130, .fiber: 19, .linoleicAcid: 7, .aLinoleicAcid: 0.7, .protein: 13
                            ])
                        ]),
                        .child: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 400, .c: 25, .d: 15, .e: 7, .k: 55, .b1: 0.6, .b2: 0.6,
                                .b3: 8, .b6: 0.6, .b9: 200, .b12: 1.2, .b5: 3, .b7: 12, .b4: 250
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1000, .cr: 15, .cu: 440, .f: 1, .i: 90, .fe: 10, .mg: 130, .mn: 1.5,
                                .mo: 22, .p: 500, .se: 30, .zn: 5, .k: 2300, .na: 1000, .cl: 1.9
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 1.7, .carbs: 130, .fiber: 25, .linoleicAcid: 10, .aLinoleicAcid: 0.9, .protein: 19
                            ])
                        ]),
                        .preteen: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 600, .c: 45, .d: 15, .e: 11, .k: 60, .b1: 0.9, .b2: 0.9,
                                .b3: 12, .b6: 1, .b9: 300, .b12: 1.8, .b5: 4, .b7: 20, .b4: 375
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1300, .cr: 21, .cu: 700, .f: 2, .i: 120, .fe: 8, .mg: 240, .mn: 1.6,
                                .mo: 34, .p: 1250, .se: 40, .zn: 8, .k: 2300, .na: 1200, .cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 2.1, .carbs: 130, .fiber: 26, .linoleicAcid: 10, .aLinoleicAcid: 1.0, .protein: 34
                            ])
                        ]),
                        .teen: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 700, .c: 65, .d: 15, .e: 15, .k: 75, .b1: 1, .b2: 1,
                                .b3: 14, .b6: 1.2, .b9: 400, .b12: 2.4, .b5: 5, .b7: 25, .b4: 400
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1300, .cr: 24, .cu: 890, .f: 3, .i: 150, .fe: 15, .mg: 360, .mn: 1.6,
                                .mo: 43, .p: 1250, .se: 55, .zn: 9, .k: 2300, .na: 1500, .cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 2.3, .carbs: 130, .fiber: 26, .linoleicAcid: 11, .aLinoleicAcid: 1.1, .protein: 46
                            ])
                        ]),
                        .adult: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 700, .c: 75, .d: 15, .e: 15, .k: 90, .b1: 1.1, .b2: 1.1,
                                .b3: 14, .b6: 1.3, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 425
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1000, .cr: 25, .cu: 900, .f: 3, .i: 150, .fe: 18, .mg: 310, .mn: 1.8,
                                .mo: 45, .p: 700, .se: 55, .zn: 8, .k: 2600, .na: 1500, .cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 2.7, .carbs: 130, .fiber: 25, .linoleicAcid: 12, .aLinoleicAcid: 1.1, .protein: 46
                            ])
                        ]),
                        .middle: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 700, .c: 75, .d: 15, .e: 15, .k: 90, .b1: 1.1, .b2: 1.1,
                                .b3: 14, .b6: 1.3, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 425
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1000, .cr: 25, .cu: 900, .f: 3, .i: 150, .fe: 18, .mg: 320, .mn: 1.8,
                                .mo: 45, .p: 700, .se: 55, .zn: 8, .k: 2600, .na: 1500, .cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 2.7, .carbs: 130, .fiber: 25, .linoleicAcid: 12, .aLinoleicAcid: 1.1, .protein: 46
                            ])
                        ]),
                        .old: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 700, .c: 75, .d: 15, .e: 15, .k: 90, .b1: 1.1, .b2: 1.1,
                                .b3: 14, .b6: 1.5, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 425
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1200, .cr: 20, .cu: 900, .f: 3, .i: 150, .fe: 8, .mg: 320, .mn: 1.8,
                                .mo: 45, .p: 700, .se: 55, .zn: 8, .k: 2600, .na: 1500, .cl: 2
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 2.7, .carbs: 130, .fiber: 21, .linoleicAcid: 11, .aLinoleicAcid: 1.1, .protein: 46
                            ])
                        ]),
                        .senior: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 700, .c: 75, .d: 15, .e: 15, .k: 90, .b1: 1.1, .b2: 1.1,
                                .b3: 14, .b6: 1.5, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 425
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1200, .cr: 20, .cu: 900, .f: 3, .i: 150, .fe: 8, .mg: 320, .mn: 1.8,
                                .mo: 45, .p: 700, .se: 55, .zn: 8, .k: 2600, .na: 1500, .cl: 1.8
                            ]),
                        ])
                    ]),
                .pregnant: AgeGroupIntakes(intakes: [
                    .teen: NutrientIntakes(intakes: [
                        .vitamin: VitaminIntakes(intakes: [
                            .a: 750, .c: 80, .d: 15, .e: 15, .k: 75, .b1: 1.4, .b2: 1.4,
                            .b3: 18, .b6: 1.9, .b9: 600, .b12: 2.6, .b5: 6, .b7: 30, .b4: 450
                        ]),
                        .mineral: MineralIntakes(intakes: [
                            .ca: 1300, .cr: 29, .cu: 1000, .f: 3, .i: 220, .fe: 27, .mg: 400, .mn: 2,
                            .mo: 50, .p: 1250, .se: 60, .zn: 12, .k: 2600, .na: 1500, .cl: 2.3
                        ]),
                        .macro: MacroIntakes(intakes: [
                            .water: 3, .carbs: 175, .fiber: 28, .linoleicAcid: 13, .aLinoleicAcid: 1.4, .protein: 71
                        ])
                    ]),
                    .adult: NutrientIntakes(intakes: [
                        .vitamin: VitaminIntakes(intakes: [
                            .a: 770, .c: 85, .d: 15, .e: 15, .k: 90, .b1: 1.4, .b2: 1.4,
                            .b3: 18, .b6: 1.9, .b9: 600, .b12: 2.6, .b5: 6, .b7: 30, .b4: 450
                        ]),
                        .mineral: MineralIntakes(intakes: [
                            .ca: 1000, .cr: 30, .cu: 1000, .f: 3, .i: 220, .fe: 27, .mg: 350, .mn: 2,
                            .mo: 50, .p: 700, .se: 60, .zn: 11, .k: 2900, .na: 1500, .cl: 2.3
                        ]),
                        .macro: MacroIntakes(intakes: [
                            .water: 3, .carbs: 175, .fiber: 28, .linoleicAcid: 13, .aLinoleicAcid: 1.4, .protein: 71
                        ])
                    ]),
                    .middle: NutrientIntakes(intakes: [
                        .vitamin: VitaminIntakes(intakes: [
                            .a: 770, .c: 85, .d: 15, .e: 15, .k: 90, .b1: 1.4, .b2: 1.4,
                            .b3: 18, .b6: 1.9, .b9: 600, .b12: 2.6, .b5: 6, .b7: 30, .b4: 450
                        ]),
                        .mineral: MineralIntakes(intakes: [
                            .ca: 1000, .cr: 30, .cu: 1000, .f: 3, .i: 220, .fe: 27, .mg: 360, .mn: 2,
                            .mo: 50, .p: 700, .se: 60, .zn: 11, .k: 2900, .na: 1500, .cl: 2.3
                        ]),
                        .macro: MacroIntakes(intakes: [
                            .water: 3, .carbs: 175, .fiber: 28, .linoleicAcid: 13, .aLinoleicAcid: 1.4, .protein: 71
                        ])
                    ])
                ]),
                .lactating: AgeGroupIntakes(
                    intakes: [
                        .teen: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 1200, .c: 115, .d: 15, .e: 19, .k: 75, .b1: 1.4, .b2: 1.6,
                                .b3: 17, .b6: 2, .b9: 500, .b12: 2.8, .b5: 7, .b7: 35, .b4: 550
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1300, .cr: 44, .cu: 1300, .f: 3, .i: 290, .fe: 10, .mg: 360, .mn: 2.6,
                                .mo: 50, .p: 1250, .se: 70, .zn: 13, .k: 2500, .na: 1500, .cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 3.8, .carbs: 210, .fiber: 29, .linoleicAcid: 13, .aLinoleicAcid: 1.3, .protein: 71
                            ])
                        ]),
                        .adult: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 1300, .c: 120, .d: 15, .e: 19, .k: 90, .b1: 1.4, .b2: 1.6,
                                .b3: 17, .b6: 2, .b9: 500, .b12: 2.8, .b5: 7, .b7: 35, .b4: 550
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1000, .cr: 45, .cu: 1300, .f: 3, .i: 290, .fe: 9, .mg: 310, .mn: 2.6,
                                .mo: 50, .p: 700, .se: 70, .zn: 12, .k: 2800, .na: 1500, .cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 3.8, .carbs: 210, .fiber: 29, .linoleicAcid: 13, .aLinoleicAcid: 1.3, .protein: 71
                            ])
                        ]),
                        .middle: NutrientIntakes(intakes: [
                            .vitamin: VitaminIntakes(intakes: [
                                .a: 1300, .c: 120, .d: 15, .e: 19, .k: 90, .b1: 1.4, .b2: 1.6,
                                .b3: 17, .b6: 2, .b9: 500, .b12: 2.8, .b5: 7, .b7: 35, .b4: 550
                            ]),
                            .mineral: MineralIntakes(intakes: [
                                .ca: 1000, .cr: 45, .cu: 1300, .f: 3, .i: 290, .fe: 9, .mg: 320, .mn: 2.6,
                                .mo: 50, .p: 700, .se: 70, .zn: 12, .k: 2800, .na: 1500, .cl: 2.3
                            ]),
                            .macro: MacroIntakes(intakes: [
                                .water: 3.8, .carbs: 210, .fiber: 29, .linoleicAcid: 13, .aLinoleicAcid: 1.3, .protein: 71
                            ])
                        ])
                    ])
            ])
        ])
}
