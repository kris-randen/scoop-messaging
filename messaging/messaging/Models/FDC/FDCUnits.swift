//
//  FDCUnit.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation
import Collections
import OrderedCollections

typealias FDCUnit = String

struct FDCUnits {
    static let masses: Set = ["kg", "g", "mg", "ug"]
    static let lengths: Set = ["km", "m","cm", "mm"]
    static let volumes: Set = ["l", "dl", "ml"]
    
    
    static func conversion(for intake: FDCfoodNutrientIntake) -> Double {
        let (name, unit) = (intake.unitName, intake.unit)
        let desc = unit.description
    
        if masses.contains(name) {
            return Units.Mass.table[name]!.conversion(to: Units.Mass.table[desc]!)
        }
        else if lengths.contains(name) {
            return Units.Length.table[name]!.conversion(to: Units.Length.table[desc]!)
        }
        else if volumes.contains(name) {
            return Units.Volume.table[name]!.conversion(to: Units.Volume.table[desc]!)
        }
        return 0
    }
    
    static func value(for intake: FDCfoodNutrientIntake) -> Double {
        intake.value * conversion(for: intake)
    }
    
    static func convert(_ intake: FDCfoodNutrientIntake) -> Intake {
        (intake.nutrient, value(for: intake))
    }
    
    static func convert(_ intakes: [FDCfoodNutrientIntake]) -> [Intake] {
        intakes.map { convert($0) }
    }
    
    static func isAmacro(_ intake: FDCfoodNutrientIntake) -> Bool {
        Nutrients.Macro.fdcMap.keySet.contains(intake.nutrientId)
    }
    
    static func isAvitamin(_ intake: FDCfoodNutrientIntake) -> Bool {
        Nutrients.Micro.Vitamin.fdcMap.keySet.contains(intake.nutrientId)
    }
    
    static func isAmineral(_ intake: FDCfoodNutrientIntake) -> Bool {
        Nutrients.Micro.Mineral.fdcMap.keySet.contains(intake.nutrientId)
    }
    
    static func macros(from intakes: [FDCfoodNutrientIntake]) -> [MacroIntake] {
        convert(intakes.filter {isAmacro($0)}) as! [MacroIntake]
    }
    
//    static func macrosAll(from intakes: [FDCfoodNutrientIntake]) -> [MacroIntake] {
//        Nutrients.Macro.zeroOrderedDict.updated(with: macros(from: intakes))
//    }
    
    static func vitamins(from intakes: [FDCfoodNutrientIntake]) -> [VitaminIntake] {
        convert(intakes.filter {isAvitamin($0)}) as! [VitaminIntake]
    }
    
    static func minerals(from intakes: [FDCfoodNutrientIntake]) -> [MineralIntake] {
        convert(intakes.filter {isAmineral($0)}) as! [MineralIntake]
    }
    
    static func macroIntakes(from intakes: [FDCfoodNutrientIntake]) -> MacroIntakes {
        MacroIntakes(intakes: OrderedDictionary(uniqueKeysWithValues: macros(from: intakes)))
    }
    
    static func macroIntakesAll(from intakes: [FDCfoodNutrientIntake]) -> MacroIntakes {
        MacroIntakes(intakes: Nutrients.Macro.zero.updated(with: macroIntakes(from: intakes).intakes))
    }
    
    static func vitaminIntakes(from intakes: [FDCfoodNutrientIntake]) -> VitaminIntakes {
        VitaminIntakes(intakes: OrderedDictionary(uniqueKeysWithValues: vitamins(from: intakes)))
    }
    
    static func vitaminIntakesAll(from intakes: [FDCfoodNutrientIntake]) -> VitaminIntakes {
        VitaminIntakes(intakes: Nutrients.Micro.Vitamin.zero.updated(with: vitaminIntakes(from: intakes).intakes))
    }
    
    static func mineralIntakes(from intakes: [FDCfoodNutrientIntake]) -> MineralIntakes {
        MineralIntakes(intakes: OrderedDictionary(uniqueKeysWithValues: minerals(from: intakes)))
    }
    
    static func mineralIntakesAll(from intakes: [FDCfoodNutrientIntake]) -> MineralIntakes {
        MineralIntakes(intakes: Nutrients.Micro.Mineral.zero.updated(with: mineralIntakes(from: intakes).intakes))
    }
    
    static func nutrientIntakes(from intakes: [FDCfoodNutrientIntake]) -> NutrientIntakes {
        NutrientIntakes(intakes: [
            .macro: macroIntakes(from: intakes),
            .vitamin: vitaminIntakes(from: intakes),
            .mineral: mineralIntakes(from: intakes)
        ])
    }
    
    static func nutrientIntakesAll(from intakes: [FDCfoodNutrientIntake]) -> NutrientIntakes {
        NutrientIntakes(intakes: [
            .macro: macroIntakesAll(from: intakes),
            .vitamin: vitaminIntakesAll(from: intakes),
            .mineral: mineralIntakesAll(from: intakes)
        ])
    }
    
    static func nutrientProfile(from intakes: [FDCfoodNutrientIntake]) -> NutrientProfile {
        NutrientProfile(intakes: nutrientIntakesAll(from: intakes), description: "FDC Data", type: .nqi)
    }
}
