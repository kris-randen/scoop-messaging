//
//  User.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/23/22.
//

import Foundation
//import FirebaseFirestoreSwift

struct Demography {
    enum AgeGroup: Equatable, Codable {
        case baby, infant
        case toddler, child
        case preteen, teen
        case adult, middle
        case old, senior
        
        static func calculate(fromAgeInMonths age: Int) -> AgeGroup {
            switch age {
            case Int.min...6:
                return .baby
            case 7...(1*12):
                return .infant
            case 13...(3*12):
                return .toddler
            case 37...(8*12):
                return .child
            case 97...(13*12):
                return .preteen
            case 157...(18*12):
                return .teen
            case 217...(30*12):
                return .adult
            case 361...(50*12):
                return .middle
            case 601...(70*12):
                return .old
            default:
                return .senior
            }
        }
    }
    
    enum GenderAndLifeStage: Equatable, Codable {
        case male
        case female
        case pregnant
        case lactating
    }
}

protocol Genderizable {
    var gender: Demography.GenderAndLifeStage { get }
}

protocol AgeGroupable: Equatable, Codable {
    var ageGroup: Demography.AgeGroup { get }
}

protocol Demographable: Genderizable, AgeGroupable {}

protocol Nameable {
    var username: String { get set }
    var firstname: String { get set }
    var lastname: String { get set }
    var fullname: String { get }
}

struct Age: Codable, Equatable { //: Ageable {
    var days: Int
    var weeks: Double { days.double / 7}
    var months: Double { days.double / 30 }
    var years: Double { days.double / 365 }
}

protocol Birthable {
    var dateOfBirth: Date { get set }
    var age: Age { get }
}

protocol Emailable {
    var email: String { get set }
}

protocol Callable {
    var cell: String { get set }
}

struct Address: Codable, Equatable {
    var apartment: String = ""
    var street: String = ""
    var city: String = ""
    var state: String = ""
}

protocol Imageable {
    var imageURL: String { get set }
}

protocol Addressable: Nameable, Emailable, Callable, Imageable {
    var address: Address { get set }
}

//struct User: Equatable, Identifiable, Codable, Addressable, Birthable, Demographable {
    
struct User: Equatable, Codable, Addressable, Birthable, Demographable {
//    @DocumentID var id: String?
    
    var username: String
    var firstname: String
    var lastname: String
    
    var fullname: String { "\(firstname) \(lastname)" }
    
    var email: String
    var cell: String = ""
    
    var imageURL: String = ""
    
    var address = Address()
    
    var dateOfBirth: Date
    var age: Age {
        Age(days: Int(Date.now.timeIntervalSince(dateOfBirth) / 86400))
    }
    
    var gender: Demography.GenderAndLifeStage
    
    var ageGroup: Demography.AgeGroup {
        Demography.AgeGroup.calculate(fromAgeInMonths: age.months.int)
    }
}
