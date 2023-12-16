//
//  Measures.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation

protocol MeasureType: Measureable, Convertible {
}

extension MeasureType {
    func conversion(to: Unit) -> Double {
        return self.value * self.unit.conversion(to: to)
    }
    
    func conversion(to: Self) -> Double {
        return conversion(to: to.unit)
    }
}

protocol Measureable {
    associatedtype Unit: UnitType
    var unit: Unit { get }
    var value: Double { get }
}

struct Mass: MeasureType {
    typealias Unit = Units.Mass
    let unit: Units.Mass
    let value: Double
}

struct Length: MeasureType {
    typealias Unit = Units.Length
    let unit: Units.Length
    let value: Double
}

struct Volume: MeasureType {
    typealias Unit = Units.Volume
    let unit: Units.Volume
    let value: Double
}

struct Energy: MeasureType {
    typealias Unit = Units.Energy
    let unit: Units.Energy
    let value: Double
}
