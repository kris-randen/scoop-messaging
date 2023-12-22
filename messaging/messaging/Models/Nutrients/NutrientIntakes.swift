//
//  NutrientIntakes.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation
import Collections
import OrderedCollections

typealias Intake = (any NutrientType, Double)
typealias MacroIntake = (Nutrient.Macro, Double)
typealias VitaminIntake = (Nutrient.Micro.Vitamin, Double)
typealias MineralIntake = (Nutrient.Micro.Mineral, Double)
typealias IntakesMacro = OrderedDictionary<Nutrient.Macro, Double>
typealias IntakesVitamin = OrderedDictionary<Nutrient.Micro.Vitamin, Double>
typealias IntakesMineral = OrderedDictionary<Nutrient.Micro.Mineral, Double>
typealias MacroIntakeAndScaled = (nutrient: Nutrient.Macro, value: Double, scaled: Double)
typealias VitaminIntakeAndScaled = (nutrient: Nutrient.Micro.Vitamin, value: Double, scaled: Double)
typealias MineralIntakeAndScaled = (nutrient: Nutrient.Micro.Mineral, value: Double, scaled: Double)


protocol Intakeable: Multipliable, NQIconvertible {
    associatedtype NutrientKey: NutrientType
    typealias Intakes = OrderedDictionary<NutrientKey, Double>
    var intakes: Intakes { get set }
    var kind: Nutrient.Kind { get }
    var nqi: Double { get }
    
    var positives: Intakes { get }
    var negatives: Intakes { get }
    
    init()
    init(intakes: Intakes)
}

extension Intakeable {
    mutating func multiply(_ factor: Double) {
        self.intakes = factor * self.intakes
    }
    
    func convertedToNQI(for energy: Energy) -> Self {
        var nqiIntakes = Intakes()
        for (nutrient, value) in intakes {
            nqiIntakes[nutrient] = nutrient.nqiFactor(with: energy) * value / nutrient.dailyValue
        }
        return Self.init(intakes: nqiIntakes)
    }
}

extension OrderedDictionary where Key: NutrientType, Value == Double {
    var nqi: Double {
        self.reduce(0) { sum, intake in
            sum + (intake.key.nqiMultiplier * intake.value)
        }
    }
}

extension Intakeable {
    init(intakes: Intakes) {
        self.init()
        self.intakes = intakes
    }
    
    var nqi: Double { intakes.nqi }
    
    var positives: Intakes {
        intakes.filter{$0.key.required}
    }
    
    var numPositives: Int {
        positives.count
    }
    
    var negatives: Intakes {
        intakes.filter{!$0.key.required}
    }
    
    var numNegatives: Int {
        negatives.count
    }
    
    var positiveNQI: Double { positives.nqi }
    
    var negativeNQI: Double { negatives.nqi }
}

protocol Intakeables: Multipliable, NQIconvertible {
    var intakes: OrderedDictionary<Nutrient.Kind, any Intakeable> { get set }
    var nqi: Double { get }
}

extension Intakeables {
    
    
    var numPositives: Int {
        let num = intakes.reduce(0) { sum, intake in
            sum + intake.value.numPositives
        }
        print("Number of positives = \(num)")
        return num
    }
    
    var numNegatives: Int {
        intakes.reduce(0) { sum, intake in
            sum + intake.value.numNegatives
        }
    }
    
    var positiveNQI: Double {
        intakes.reduce(0) { sum, intake in
            sum + intake.value.positiveNQI
        }
    }
    
    var negativeNQI: Double {
        let neg = intakes.reduce(0) { sum, intake in
            sum + intake.value.negativeNQI
        }
        print("Negative NQI = \(neg)")
        return neg
    }
    
    var nqi: Double {
        positiveNQI + Double(numPositives) * negativeNQI
    }
}


struct NutrientIntakes: Intakeables {
    typealias Intakes = OrderedDictionary<Nutrient.Kind, any Intakeable>
    var intakes: Intakes
    
    mutating func multiply(_ factor: Double) {
        self.intakes = [
            .macro: factor * (self.intakes[.macro] as! MacroIntakes),
            .vitamin: factor * (self.intakes[.vitamin] as! VitaminIntakes),
            .mineral: factor * (self.intakes[.mineral] as! MineralIntakes)
        ]
    }
    
    func convertedToNQI(for energy: Energy) -> Self {
        var nqiIntakes = Intakes()
        nqiIntakes[.macro] = intakes[.macro]!.convertedToNQI(for: energy)
        nqiIntakes[.vitamin] = intakes[.vitamin]!.convertedToNQI(for: energy)
        nqiIntakes[.mineral] = intakes[.mineral]!.convertedToNQI(for: energy)
        return Self.init(intakes: nqiIntakes)
    }
    
}

protocol NQIconvertible {
    func convertedToNQI(for energy: Energy) -> Self
}

struct MacroIntakes: Intakeable {
    typealias NutrientKey = Nutrient.Macro
    typealias Intakes = OrderedDictionary<NutrientKey, Double>
    var intakes: Intakes = Intakes()
    var kind: Nutrient.Kind = .macro
    
    init() {
        
    }
    
    var negatives: Intakes {
        var negs = self.intakes.filter {!$0.key.required}
        if self.intakes[.fiber] ?? 0 > 1 {
            negs.removeValue(forKey: .carbs)
        }
        return negs
    }
}

struct VitaminIntakes: Intakeable {
    typealias NutrientKey = Nutrient.Micro.Vitamin
    typealias Intakes = OrderedDictionary<NutrientKey, Double>
    var intakes: Intakes = Intakes()
    var kind: Nutrient.Kind = .vitamin
}

struct MineralIntakes: Intakeable {
    typealias NutrientKey = Nutrient.Micro.Mineral
    typealias Intakes = OrderedDictionary<NutrientKey, Double>
    var intakes: Intakes = Intakes()
    var kind: Nutrient.Kind = .mineral
}

struct SugarIntakes: Intakeable {
    typealias NutrientKey = Nutrient.Macro.Sugar
    typealias Intakes = OrderedDictionary<NutrientKey, Double>
    var intakes: Intakes = Intakes()
    var kind: Nutrient.Kind = .macro
    
    init() {
        
    }
    
    var negatives: Intakes {
        self.intakes.filter {!$0.key.required}
    }
}

struct CarbIntakes: Intakeable {
    typealias NutrientKey = Nutrient.Macro.Carb
    typealias Intakes = OrderedDictionary<NutrientKey, Double>
    var intakes: Intakes = Intakes()
    var kind: Nutrient.Kind = .macro
    
    init() {
        
    }
    
    var negatives: Intakes {
        self.intakes.filter {!$0.key.required}
    }
}


struct FatIntakes: Intakeable {
    typealias NutrientKey = Nutrient.Macro.Fat
    typealias Intakes = OrderedDictionary<NutrientKey, Double>
    var intakes: Intakes = Intakes()
    var kind: Nutrient.Kind = .macro
    
    init() {
        
    }
    
    var negatives: Intakes {
        self.intakes.filter {!$0.key.required}
    }
}
