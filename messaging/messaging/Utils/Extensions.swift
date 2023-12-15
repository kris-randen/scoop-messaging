//
//  Extensions.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import SwiftUI
import Foundation
import UIKit
import OrderedCollections

protocol ComparableHash: Comparable, Hashable {}

extension Set {
    mutating func union(_ other: Self) {
        self = self.union(other)
    }
    
    mutating func union(with others: any Sequence<Self>) {
        self = self.union(with: others)
    }
    
    mutating func intersection(_ other: Self) {
        self = self.intersection(other)
    }
    
    mutating func intersection(with others: any Sequence<Self>) {
        self = self.intersection(with: others)
    }
    
    func union(with others: any Sequence<Self>) -> Self {
        others.reduce(into: self) { $0.union($1) }
    }
    
    func intersection(with others: any Sequence<Self>) -> Self {
        others.reduce(into: self) { $0.intersection($1) }
    }
    
    static func union(of sets: any Sequence<Self>) -> Self {
        Self().union(with: sets)
    }
    
    static func intersection(of sets: any Sequence<Self>) -> Self {
        Self().intersection(with: sets)
    }
    
    static func union(lhs: Self, rhs: Self) -> Self {
        Set.union(of: [lhs, rhs])
    }
    
    static func intersection(lhs: Self, rhs: Self) -> Self {
        Set.intersection(of: [lhs, rhs])
    }
}

extension Array where Element: Hashable {
    var set: Set<Element> { Set(self) }
    
    func union(with other: Set<Element>) -> Set<Element> {
        set.union(other)
    }
    
    func union(with others: [Set<Element>]) -> Set<Element> {
        set.union(with: others)
    }
    
    func union(with other: Self) -> Self {
        Array(union(with: other.set))
    }
    
    func union(with others: any Sequence<Self>) -> Self {
        Array(union(with: others.map { Set($0) }))
    }

}

// Defining the KeyValueProtocol so that I don't have to repeat the extensions of Dictionary for both Dictionary and OrderedDictionary

protocol KeyValueCollection {
    associatedtype Key: Hashable
    associatedtype Value
    var keySet: Set<Key> { get }
    subscript(key: Key) -> Value? { get set }
    
    mutating func update(value: Value, forKey key: Key)
}

extension Dictionary: KeyValueCollection {
    var keySet: Set<Key> { Set(self.keys) }
    
    mutating func update(value: Value, forKey key: Key) {
        self.updateValue(value, forKey: key)
    }
}

extension OrderedDictionary: KeyValueCollection {
    var keySet: Set<Key> { Set(self.keys) }
    
    mutating func update(value: Value, forKey key: Key) {
        self.updateValue(value, forKey: key)
    }
}

extension KeyValueCollection {
    func keysUnion(with other: Self) -> Set<Key> {
        keySet.union(other.keySet)
    }
    
    func keysUnion(with others: any Sequence<Self>) -> Set<Key> {
        keySet.union(with: others.map { $0.keySet })
    }
    
    func keysIntersection(with other: Self) -> Set<Key> {
        keySet.intersection(other.keySet)
    }
    
    func keysIntersection(with others: any Sequence<Self>) -> Set<Key> {
        keySet.intersection(with: others.map { $0.keySet } )
    }
}

extension KeyValueCollection {
    
    func valueMerge(forKey key: Key, with dict: Self) -> Value? { self[key] ?? dict[key] }
    
    func valueUpdate(forKey key: Key, with dict: Self) -> Value? { dict[key] ?? self[key] }
    
    func merged(withNonintersecting dict: Self) -> Self {
        keysUnion(with: dict).reduce(into: self) {
            $0.update(value: valueMerge(forKey: $1, with: dict)!, forKey: $1)}
    }
    
    mutating func merge(nonintersecting dict: Self) {
        self = merged(withNonintersecting: dict)
    }
    
    func updated(with dict: Self) -> Self {
        keysUnion(with: dict).reduce(into: self) {
            $0.update(value: valueUpdate(forKey: $1, with: dict)!, forKey: $1)
        }
    }
    
    mutating func update(with dict: Self) {
        self = updated(with: dict)
    }
    
    func replaced(with dict: Self) -> Self {
        keySet.reduce(into: self) {
            $0.update(value: valueUpdate(forKey: $1, with: dict)!, forKey: $1)
        }
    }
    
    mutating func replace(with dict: Self) {
        self = replaced(with: dict)
    }
    
    func merging(nonintersecting dicts: any Sequence<Self>) -> Self {
        dicts.reduce(into: self) { $0.merge(nonintersecting: $1) }
    }
    
    func merging(nonintersecting dict: Self) -> Self {
        merging(nonintersecting: [dict])
    }
    
    static func merge(dicts: [[Key: Value]]) -> [Key: Value] {
        return dicts.last?.merging(nonintersecting: dicts.dropLast()) ?? [:]
    }
}

extension Array {
    func zipLeft<Value>(_ values: [Value]) -> [(Element, Value)] {
        var zipped = [(Element, Value)]()
        for (index, element) in self.enumerated() where index < values.count {
            zipped.append((element, values[index]))
        }
        return zipped
    }
    
    func zipRight<Value>(_ values: [Value]) -> [(Element, Value)] {
        var zipped = [(Element, Value)]()
        for (index, value) in values.enumerated() where index < self.count {
            zipped.append((self[index], value))
        }
        return zipped
    }
    
    func shorter<Value>(than values: [Value]) -> Bool {
        return self.count < values.count
    }
    
    func zip<Value>(_ values: [Value]) -> [(Element, Value)] {
        return self.shorter(than: values) ? self.zipLeft(values) : self.zipRight(values)
    }
}


extension CaseIterable where Self: Hashable {
    static func valuesDict<Value>(value: Value) -> [Self: Value] {
        let zeros = Array(repeating: value, count: allCases.count)
        return Dictionary(uniqueKeysWithValues: zip(allCases, zeros))
    }
    static var zeroDict: [Self: Double] { valuesDict(value: 0.0) }
}

extension CaseIterable where Self: ComparableHash {
    static func valuesOrderedDict<Value>(value: Value) -> OrderedDictionary<Self, Value> {
        OrderedDictionary(uniqueKeysWithValues: self.valuesDict(value: value))
    }
    
    static var zeroOrderedDict: OrderedDictionary<Self, Double> { valuesOrderedDict(value: 0.0) }
}

func * <Element>(element: Element, count: Int) -> [Element] {
    return Array(repeating: element, count: count)
}

func * <Element>(count: Int, element: Element) -> [Element] {
    return Array(repeating: element, count: count)
}

extension Array where Element: Hashable {
    func zipDict<Value>(_ values: [Value]) -> [Element: Value] {
        return Dictionary(uniqueKeysWithValues: self.zip(values))
    }
}

extension Array where Element: ComparableHash {
    func zipOrderedDictByKeys<Value>(_ values: [Value], ascending: Bool = true) -> OrderedDictionary<Element, Value> {
        return OrderedDictionary(uniqueKeysWithValues: self.zip(values))
            .sortedByKeys(ascending: ascending)
    }
 }


extension OrderedDictionary where Key: Comparable {
    mutating func sortByKeys(ascending: Bool = true) {
        ascending ? self.sort { $0.key < $1.key } : self.sort {$0.key > $1.key }
    }
    
    func sortedByKeys(ascending: Bool = true) -> Self {
        var result = self
        result.sortByKeys(ascending: ascending)
        return result
    }
    
    func elementsSortedByKeys(ascending: Bool = true) -> [(key: Key, value: Value)] {
        return ascending ? sorted { $0.key < $1.key } : sorted { $0.key > $1.key }
    }
    
    var elementsKeysAscending: [(key: Key, value: Value)] { elementsSortedByKeys(ascending: true) }
    var elementsKeysDescending: [(key: Key, value: Value)] { elementsSortedByKeys(ascending: false) }
}


extension OrderedDictionary where Value: Comparable {
    mutating func sortByValues(ascending: Bool = true) {
        ascending ? self.sort { $0.value < $1.value } : self.sort {$0.value > $1.value }
    }
    
    func sortedByValues(ascending: Bool = true) -> Self {
        var result = self
        result.sortByValues(ascending: ascending)
        return result
    }
    
    func elementsSortedByValues(ascending: Bool = true) -> [(key: Key, value: Value)] {
        return ascending ? sorted { $0.value < $1.value } : sorted { $0.value > $1.value }
    }
    
    var elementsValuesAscending:  [(key: Key, value: Value)]  { elementsSortedByValues(ascending: true) }
    var elementsValuesDescending:  [(key: Key, value: Value)]  { elementsSortedByValues(ascending: false) }
    
}

extension Int {
    var double: Double { Double(self) }
    
    var degrees: Angle { Angle(degrees: Double(self)) }
}

extension Double {
    var int: Int { Int(self) }
    
    var degrees: Angle { Angle(degrees: self) }
}

extension CGPoint {
    static var zero: CGPoint { CGPoint(x: 0, y: 0) }
    
    func offset(to p: CGPoint) -> CGPoint {
        CGPoint(x: self.x + p.x, y: self.y + p.y)
    }
    
    static prefix func - (p: CGPoint) -> CGPoint {
        return CGPoint(x: -p.x, y: -p.y)
    }
}

extension RectangleProperties {
    var minDim: CGFloat { min(width, height) }
    var originLocal: CGPoint { CGPoint.zero }
    var originGlobal: CGPoint { origin }
    
    var topLeft: CGPoint { CGPoint.zero }
    var topRight: CGPoint { CGPoint(x: width, y: 0) }
    var bottomLeft: CGPoint { CGPoint(x: 0, y: height) }
    var bottomRight: CGPoint { CGPoint(x: width, y: height) }
    
    var center: CGPoint { CGPoint(x: width / 2, y: height / 2) }
    var topCenter: CGPoint { CGPoint(x: width / 2, y: 0) }
    var bottomCenter: CGPoint { CGPoint(x: width / 2, y: height)}
    var leftCenter: CGPoint { CGPoint(x: 0, y: height / 2) }
    var rightCenter: CGPoint { CGPoint(x: width, y: height / 2) }
    
    var topLeftGlobal: CGPoint { topLeft.offset(to: originGlobal) }
    var topRightGlobal: CGPoint { topRight.offset(to: originGlobal) }
    var bottomLeftGlobal: CGPoint { bottomLeft.offset(to: originGlobal) }
    var bottomRightGlobal: CGPoint { bottomRight.offset(to: originGlobal) }
    
    var centerGlobal: CGPoint { center.offset(to: originGlobal) }
    var topCenterGlobal: CGPoint { topCenter.offset(to: originGlobal) }
    var bottomCenterGlobal: CGPoint { bottomCenter.offset(to: originGlobal) }
    var leftCenterGlobal: CGPoint { leftCenter.offset(to: originGlobal) }
    var rightCenterGlobal: CGPoint { rightCenter.offset(to: originGlobal) }
    
    var naturalOrientation: CGRect.Orientation {
        return height > width ? .vertical : .horizontal
    }
}

extension RoundedRectProperties {
    var origin: CGPoint { CGPoint.zero }
    var originGlobal: CGPoint { CGPoint(x: x, y: y) }
    var width: CGFloat { width }
    var height: CGFloat { height }
    
    var majorDim: CGFloat {
        switch orientation {
        case .horizontal:
            return width
        case .vertical:
            return height
        }
    }
    
    var minorDim: CGFloat {
        switch orientation {
        case .horizontal:
            return height
        case .vertical:
            return width
        }
    }
    
    func scaling(factor: CGFloat) -> CGFloat {
        if majorDim >= minorDim { return factor }
        else { return 0.5 }
    }
    
    var radius: CGFloat { scaling(factor: radiusScaling) * minDim }
    
    var topLeftLeft: CGPoint { CGPoint(x: 0, y: radius) }
    var topLeftCenter: CGPoint { CGPoint(x: radius, y: radius) }
    var topLeftRight: CGPoint { CGPoint(x: radius, y: 0) }
    
    var topRightLeft: CGPoint { CGPoint(x: width - radius, y: 0) }
    var topRightCenter: CGPoint { CGPoint(x: width - radius, y: radius) }
    var topRightRight: CGPoint { CGPoint(x: width, y: radius) }
    
    var bottomLeftLeft: CGPoint { CGPoint(x: 0, y: height - radius) }
    var bottomLeftCenter: CGPoint { CGPoint(x: radius, y: height - radius) }
    var bottomLeftRight: CGPoint { CGPoint(x: radius, y: height) }
    
    var bottomRightLeft: CGPoint { CGPoint(x: width - radius, y: height) }
    var bottomRightCenter: CGPoint { CGPoint(x: width - radius, y: height - radius) }
    var bottomRightRight: CGPoint { CGPoint(x: width, y: height - radius) }
    
    var center: CGPoint { CGPoint(x: width / 2, y: height / 2) }
    
    var topOuterCenter: CGPoint { CGPoint(x: width / 2, y: 0) }
    var topInnerCenter: CGPoint { CGPoint(x: width / 2, y: radius) }
    var bottomInnerCenter: CGPoint { CGPoint(x: width / 2, y: height - radius)}
    var bottomOuterCenter: CGPoint { CGPoint(x: width / 2, y: height)}
    var leftOuterCenter: CGPoint { CGPoint(x: 0, y: height / 2) }
    var leftInnerCenter: CGPoint { CGPoint(x: radius, y: height / 2) }
    var rightInnerCenter: CGPoint { CGPoint(x: width - radius, y: height / 2) }
    var rightOuterCenter: CGPoint { CGPoint(x: width, y: height / 2) }
    
    var topLeftLeftGlobal: CGPoint { topLeftLeft.offset(to: originGlobal) }
    var topLeftCenterGlobal: CGPoint { topLeftCenter.offset(to: originGlobal) }
    var topLeftRightGlobal: CGPoint { topLeftRight.offset(to: originGlobal) }
    
    var topRightLeftGlobal: CGPoint { topRightLeft.offset(to: originGlobal) }
    var topRightCenterGlobal: CGPoint { topRightCenter.offset(to: originGlobal) }
    var topRightRightGlobal: CGPoint { topRightRight.offset(to: originGlobal) }
    
    var bottomLeftLeftGlobal: CGPoint { bottomLeftLeft.offset(to: originGlobal) }
    var bottomLeftCenterGlobal: CGPoint { bottomLeftCenter.offset(to: originGlobal) }
    var bottomLeftRightGlobal: CGPoint { bottomLeftRight.offset(to: originGlobal) }
    
    var bottomRightLeftGlobal: CGPoint { bottomRightLeft.offset(to: originGlobal) }
    var bottomRightCenterGlobal: CGPoint { bottomRightCenter.offset(to: originGlobal) }
    var bottomRightRightGlobal: CGPoint { bottomRightRight.offset(to: originGlobal) }
    
    
    var centerGlobal: CGPoint { center.offset(to: originGlobal) }
    
    var topOuterCenterGlobal: CGPoint { topOuterCenter.offset(to: originGlobal) }
    var topInnerCenterGlobal: CGPoint { topInnerCenter.offset(to: originGlobal) }
    var bottomInnerCenterGlobal: CGPoint { bottomInnerCenter.offset(to: originGlobal)}
    var bottomOuterCenterGlobal: CGPoint { bottomOuterCenter.offset(to: originGlobal)}
    var leftOuterCenterGlobal: CGPoint { leftOuterCenter.offset(to: originGlobal) }
    var leftInnerCenterGlobal: CGPoint { leftInnerCenter.offset(to: originGlobal) }
    var rightInnerCenterGlobal: CGPoint { rightInnerCenter.offset(to: originGlobal) }
    var rightOuterCenterGlobal: CGPoint { rightOuterCenter.offset(to: originGlobal) }
    
    var leftFlank: CGRect {
        CGRect(
            x: topLeftLeftGlobal.x,
            y: topLeftLeftGlobal.y,
            width: radius,
            height: height - (2 * radius)
        )
    }
    var rightFlank: CGRect {
        CGRect(
            x: topRightCenterGlobal.x,
            y: topRightCenterGlobal.y,
            width: radius,
            height: height - (2 * radius)
        )
    }
    var topFlank: CGRect {
        CGRect(
            x: topLeftRightGlobal.x,
            y: topLeftRightGlobal.y,
            width: width - (2 * radius),
            height: radius
        )
    }
    var bottomFlank: CGRect {
        CGRect(
            x: bottomLeftCenterGlobal.x,
            y: bottomLeftCenterGlobal.y,
            width: width - (2 * radius),
            height: radius
        )
    }
}

extension CGRect {
    enum Orientation {
        case vertical
        case horizontal
    }
    
    var originLocal: CGPoint { CGPoint.zero }
    var originGlobal: CGPoint { origin }
    
    var topLeft: CGPoint { CGPoint.zero }
    var topRight: CGPoint { CGPoint(x: width, y: 0) }
    var bottomLeft: CGPoint { CGPoint(x: 0, y: height) }
    var bottomRight: CGPoint { CGPoint(x: width, y: height) }
    
    var center: CGPoint { CGPoint(x: width / 2, y: height / 2) }
    var topCenter: CGPoint { CGPoint(x: width / 2, y: 0) }
    var bottomCenter: CGPoint { CGPoint(x: width / 2, y: height)}
    var leftCenter: CGPoint { CGPoint(x: 0, y: height / 2) }
    var rightCenter: CGPoint { CGPoint(x: width, y: height / 2) }
    
    var topLeftGlobal: CGPoint { topLeft.offset(to: originGlobal) }
    var topRightGlobal: CGPoint { topRight.offset(to: originGlobal) }
    var bottomLeftGlobal: CGPoint { bottomLeft.offset(to: originGlobal) }
    var bottomRightGlobal: CGPoint { bottomRight.offset(to: originGlobal) }
    
    var centerGlobal: CGPoint { center.offset(to: originGlobal) }
    var topCenterGlobal: CGPoint { topCenter.offset(to: originGlobal) }
    var bottomCenterGlobal: CGPoint { bottomCenter.offset(to: originGlobal) }
    var leftCenterGlobal: CGPoint { leftCenter.offset(to: originGlobal) }
    var rightCenterGlobal: CGPoint { rightCenter.offset(to: originGlobal) }
    
    var orientation: Orientation {
        return height > width ? .vertical : .horizontal
    }
}

extension RoundedRect {
    
}


extension Path {
    
}

extension GeometryProxy {
    var bounds: CGRect { frame(in: .local) }
    var origin: CGPoint { bounds.origin }
    
    var minX: CGFloat { bounds.minX }
    var minY: CGFloat { bounds.minY }
    var midX: CGFloat { bounds.midX }
    var midY: CGFloat { bounds.midY }
    var maxX: CGFloat { bounds.maxX }
    var maxY: CGFloat { bounds.maxY }
    
    var height: CGFloat { size.height }
    var width: CGFloat { size.width }
    var minDim: CGFloat { bounds.minDim }
    
    var boundsGlobal: CGRect { frame(in: .global) }
    var originGlobal: CGPoint { boundsGlobal.origin }
    
    var minXGlobal: CGFloat { boundsGlobal.minX }
    var minYGlobal: CGFloat { boundsGlobal.minY }
    var midXGlobal: CGFloat { boundsGlobal.midX }
    var midYGlobal: CGFloat { boundsGlobal.midY }
    var maxXGlobal: CGFloat { boundsGlobal.maxX }
    var maxYGlobal: CGFloat { boundsGlobal.maxY }
    
    
    var topLeft: CGPoint { bounds.topLeft }
    var topRight: CGPoint { bounds.topRight }
    var bottomLeft: CGPoint { bounds.bottomLeft }
    var bottomRight: CGPoint { bounds.bottomRight }
    
    var center: CGPoint { CGPoint(x: width / 2, y: height / 2) }
    var topCenter: CGPoint { CGPoint(x: width / 2, y: 0) }
    var bottomCenter: CGPoint { CGPoint(x: width / 2, y: height)}
    var leftCenter: CGPoint { CGPoint(x: 0, y: height / 2) }
    var rightCenter: CGPoint { CGPoint(x: width, y: height / 2) }
    
    var topLeftGlobal: CGPoint { boundsGlobal.topLeftGlobal }
    var topRightGlobal: CGPoint { boundsGlobal.topRightGlobal }
    var bottomLeftGlobal: CGPoint { boundsGlobal.bottomLeftGlobal }
    var bottomRightGlobal: CGPoint { boundsGlobal.bottomRightGlobal }
    
    var centerGlobal: CGPoint { center.offset(to: originGlobal) }
    var topCenterGlobal: CGPoint { topCenter.offset(to: originGlobal) }
    var bottomCenterGlobal: CGPoint { bottomCenter.offset(to: originGlobal) }
    var leftCenterGlobal: CGPoint { leftCenter.offset(to: originGlobal) }
    var rightCenterGlobal: CGPoint { rightCenter.offset(to: originGlobal) }
}

func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint { lhs.offset(to: rhs) }
func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint { lhs.offset(to: -rhs) }
func *(lhs: Double, rhs: CGPoint) -> CGPoint { CGPoint(x: lhs*rhs.x, y: lhs*rhs.y) }

extension View {
    var screen: CGRect {
        UIScreen.main.bounds
    }
    var screenWidth: CGFloat {
        screen.width
    }
    var screenHeight: CGFloat {
        screen.height
    }
}

extension CGRect {
    var minDim: CGFloat { min(width, height) }
    
    var maxDim: CGFloat { max(width, height) }
}

//#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
//#endif

extension String {
    func doesContain(_ other: String) -> Bool {
        other.isEmpty || self.contains(other)
    }
}
