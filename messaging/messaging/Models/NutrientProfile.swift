//
//  NutrientProfile.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation

protocol NutrientProfileable {
    var description: String { get }
    var type: NutrientValueType { get }
    var intakes: Intakeables { get }
    var serving: any Serveable { get }
    
    var nqi: Double { get }
}

extension NutrientProfileable {
    var nqi: Double { intakes.nqi }
}



protocol ServeableNutrientProfile: NutrientProfileable {
    var serving: any Serveable { get }
}

struct NutrientProfile: NutrientProfileable {
    var intakes: Intakeables
    var description: String
    var type: NutrientValueType
    var serving: any Serveable = MassServing(unit: .gm, value: 100)
}

struct NutrientProfileServed: ServeableNutrientProfile {
    var intakes: Intakeables
    var serving: any Serveable
    var description: String
    var type: NutrientValueType
}



struct Profiles {
    static let dict: [String: NutrientProfile] = [
                "boost": boostHighProteinDrink,
                "boost high protein drink": boostHighProteinDrink,
                "sugar": sugarWhite,
                "arugula": arugula,
                "carrot": carrot
    ]
    static let profile = NutrientProfile(
        intakes: NutrientIntakes(intakes: [
            .vitamin: VitaminIntakes(intakes: [
                .a: 900, .c: 90, .d: 20, .e: 15, .k: 120, .b1: 1.2, .b2: 1.3,
                .b3: 16, .b6: 1.7, .b9: 400, .b12: 2.4, .b5: 5, .b7: 30, .b4: 550
            ]),
            .mineral: MineralIntakes(intakes: [
                .Ca: 1300, .Cr: 35, .Cu: 900, .F: 4, .I: 150, .Fe: 18, .Mg: 420, .Mn: 2.3,
                .Mo: 45, .P: 1250, .Se: 55, .Zn: 11, .K: 4700, .Na: 2300, .Cl: 2.3
            ]),
            .macro: MacroIntakes(intakes: [
                .water: 3.7, .carbs: 130, .sugar: 20, .fats: 78, .fiber: 38, .linoleicAcid: 17, .aLinoleicAcid: 1.6, .protein: 56
            ])
        ]), description: "Daily Value",
        type: .value)
    
    static let boostHighProteinDrink = NutrientProfile(
        intakes: NutrientIntakes(intakes: [
            .vitamin: VitaminIntakes(intakes: [
                .a: 1.6, .c: 8, .d: 4.8, .e: 8, .k: 2, .b1: 2, .b2: 3.2,
                .b3: 1.6, .b4: 0.8, .b5: 2, .b6: 2.8, .b7: 4, .b9: 2, .b12: 3.6
            ]),
            .mineral: MineralIntakes(intakes: [
                .Ca: 2.4, .Cr: 4, .Cu: 3.6,.F: 0, .I: 2, .Fe: 2, .Mg: 2, .Mn: 2.8,
                .Mo: 2, .P: 2, .Se: 2.8, .Zn: 3.2, .K: 0.8, .Na: 0.8, .Cl: 1.2
            ]),
            .macro: MacroIntakes(intakes: [
                .fats: 0.64, .carbs: 0.8, .fiber: 0, .sugar: 4.4, .protein: 3.2
            ])
        ]), description: Constants.Food.boostHighProteinDrink,
        type: .nqi)
    
    static let sugarWhite = NutrientProfile(
        intakes: NutrientIntakes(intakes: [
            .vitamin: VitaminIntakes(intakes: [
                .a: 0, .c: 0, .d: 0, .e: 0, .k: 0, .b1: 0, .b2: 0,
                .b3: 0, .b4: 0, .b5: 0, .b6: 0, .b7: 0, .b9: 0, .b12: 0
            ]),
            .mineral: MineralIntakes(intakes: [
                .Ca: 0, .Cr: 0, .Cu: 0,.F: 0, .I: 0, .Fe: 0, .Mg: 0, .Mn: 0,
                .Mo: 0, .P: 0, .Se: 0, .Zn: 0, .K: 0, .Na: 0, .Cl: 0
            ]),
            .macro: MacroIntakes(intakes: [
                .fats: 0, .carbs: 2, .fiber: 0, .sugar: 25, .protein: 0
            ])
        ]), description: Constants.Food.sugarWhite,
        type: .nqi)
    
    static let arugula = NutrientProfile(
        intakes: NutrientIntakes(intakes: [
            .vitamin: VitaminIntakes(intakes: [
                .a: 10.6, .c: 13.3, .d: 0, .e: 0, .k: 72.7, .b1: 2.9, .b2: 5.3,
                .b3: 1.5, .b4: 2.2, .b5: 7, .b6: 3.4, .b7: 0, .b9: 19.4, .b12: 0
            ]),
            .mineral: MineralIntakes(intakes: [
                .Ca: 9.8, .Cr: 0, .Cu: 6.8,.F: 0, .I: 0, .Fe: 6.5, .Mg: 9, .Mn: 11.2,
                .Mo: 0, .P: 3.33, .Se: 0.44, .Zn: 3.4, .K: 6.3, .Na: 0.94, .Cl: 0
            ]),
            .macro: MacroIntakes(intakes: [
                .fats: 0.68, .carbs: 1.06, .fiber: 4.57, .sugar: 0, .protein: 4.13
            ])
        ]), description: Constants.Food.arugula,
        type: .nqi)
    
    static let carrot = NutrientProfile(intakes: NutrientIntakes(intakes: [
        .macro: MacroIntakes(intakes: [
            .carbs: 1.70,
            .fiber: 4.88,
            .sugar: 0,
            .protein: 0.91,
            .fats: 0.15
        ]),
        .vitamin: VitaminIntakes(intakes: [
            .a: 45.3,
            .c: 3.2,
            .d: 0,
            .e: 2.15,
            .k: 5.37,
            .b1: 2.68,
            .b2: 2.18,
            .b3: 3,
            .b4: 0.78,
            .b5: 2.7,
            .b6: 4,
            .b7: 0,
            .b9: 2.32,
            .b12: 0
        ]),
        .mineral: MineralIntakes(intakes: [
            .Ca: 1.24,
            .Cr: 0,
            .Cu: 2.44,
            .F: 0.04,
            .I: 0,
            .Fe: 0.81,
            .Mg: 1.39,
            .Mn: 3,
            .Mo: 0,
            .P: 1.4,
            .Se: 0.09,
            .Zn: 1.06,
            .K: 3.32,
            .Na: 1.46,
            .Cl: 0
        ])
    ]), description: Constants.Food.carrot, type: .nqi)
}

struct FoodItemProfiles {
    static let boostHighProteinDrink = "Boost High Protein Drink"
    static let boostVeryHighEnergyDrink = "Boost Very High Energy Drink"
    static let boostMaxMenShake = "Boost Max Men Shake"
}
