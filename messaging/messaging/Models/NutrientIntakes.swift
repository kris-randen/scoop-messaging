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

protocol Intakeable {
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

protocol Intakeables {
    var intakes: OrderedDictionary<Nutrients.Kind, any Intakeable> { get }
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
    var intakes: OrderedDictionary<Nutrients.Kind, any Intakeable>
}

struct MacroIntakes: Intakeable {
    typealias Nutrient = Nutrients.Macro
    typealias Intakes = OrderedDictionary<Nutrient, Double>
    var intakes: Intakes = Intakes()
    var kind: Nutrients.Kind = .macro
    
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
