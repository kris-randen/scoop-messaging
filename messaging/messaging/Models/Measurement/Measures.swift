//
//  Measures.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation

protocol Measureable {
    associatedtype Unit: UnitType
    var unit: Unit { get }
    var value: Double { get set }
}

protocol ConvertibleMeasure: Measureable, Convertible {
}

extension ConvertibleMeasure {
    func conversion(to: Unit) -> Double {
        return self.value * self.unit.conversion(to: to)
    }
    
    func conversion(to: Self) -> Double {
        return conversion(to: to.unit)
    }
}

struct Mass: ConvertibleMeasure {
    typealias Unit = Units.Mass
    let unit: Units.Mass
    var value: Double
}

struct Length: ConvertibleMeasure {
    typealias Unit = Units.Length
    let unit: Units.Length
    var value: Double
}

struct Volume: ConvertibleMeasure {
    typealias Unit = Units.Volume
    let unit: Units.Volume
    var value: Double
}

struct Energy: ConvertibleMeasure {
    typealias Unit = Units.Energy
    let unit: Units.Energy
    var value: Double
    static var dailyValue: Double = 2000
}
