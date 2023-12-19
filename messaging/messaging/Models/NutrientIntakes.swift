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
typealias MacroIntake = (Nutrients.Macro, Double)
typealias VitaminIntake = (Nutrients.Micro.Vitamin, Double)
typealias MineralIntake = (Nutrients.Micro.Mineral, Double)
typealias IntakesMacro = OrderedDictionary<Nutrients.Macro, Double>
typealias IntakesVitamin = OrderedDictionary<Nutrients.Micro.Vitamin, Double>
typealias IntakesMineral = OrderedDictionary<Nutrients.Micro.Mineral, Double>
typealias MacroIntakeAndScaled = (nutrient: Nutrients.Macro, value: Double, scaled: Double)
typealias VitaminIntakeAndScaled = (nutrient: Nutrients.Micro.Vitamin, value: Double, scaled: Double)
typealias MineralIntakeAndScaled = (nutrient: Nutrients.Micro.Mineral, value: Double, scaled: Double)


protocol Intakeable: Multipliable, NQIconvertible {
    associatedtype Nutrient: NutrientType
    typealias Intakes = OrderedDictionary<Nutrient, Double>
    var intakes: Intakes { get set }
    var kind: Nutrients.Kind { get }
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
    var intakes: OrderedDictionary<Nutrients.Kind, any Intakeable> { get set }
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
    typealias Intakes = OrderedDictionary<Nutrients.Kind, any Intakeable>
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
    typealias Nutrient = Nutrients.Macro
    typealias Intakes = OrderedDictionary<Nutrient, Double>
    var intakes: Intakes = Intakes()
    var kind: Nutrients.Kind = .macro
    
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
    typealias Nutrient = Nutrients.Micro.Vitamin
    typealias Intakes = OrderedDictionary<Nutrient, Double>
    var intakes: Intakes = Intakes()
    var kind: Nutrients.Kind = .vitamin
}

struct MineralIntakes: Intakeable {
    typealias Nutrient = Nutrients.Micro.Mineral
    typealias Intakes = OrderedDictionary<Nutrient, Double>
    var intakes: Intakes = Intakes()
    var kind: Nutrients.Kind = .mineral
}

struct SugarIntakes: Intakeable {
    typealias Nutrient = Nutrients.Macro.Sugar
    typealias Intakes = OrderedDictionary<Nutrient, Double>
    var intakes: Intakes = Intakes()
    var kind: Nutrients.Kind = .macro
    
    init() {
        
    }
    
    var negatives: Intakes {
        self.intakes.filter {!$0.key.required}
    }
}

struct CarbIntakes: Intakeable {
    typealias Nutrient = Nutrients.Macro.Carb
    typealias Intakes = OrderedDictionary<Nutrient, Double>
    var intakes: Intakes = Intakes()
    var kind: Nutrients.Kind = .macro
    
    init() {
        
    }
    
    var negatives: Intakes {
        self.intakes.filter {!$0.key.required}
    }
}


struct FatIntakes: Intakeable {
    typealias Nutrient = Nutrients.Macro.Fat
    typealias Intakes = OrderedDictionary<Nutrient, Double>
    var intakes: Intakes = Intakes()
    var kind: Nutrients.Kind = .macro
    
    init() {
        
    }
    
    var negatives: Intakes {
        self.intakes.filter {!$0.key.required}
    }
}
