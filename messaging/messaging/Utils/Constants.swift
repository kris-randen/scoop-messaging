//
//  Constants.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import SwiftUI
import Foundation
//import Firebase

struct Constants {
    static let space = " "
    static let colon = ":"
    static let DEBUG = "DEBUG"
    static let SUCESS = "SUCCESS"
    static let FAILURE = "FAILURE"
    
    static let APIkeyFDC = "DEMO_KEY"
    static let APIurlstringFDC = "https://api.nal.usda.gov/fdc/v1/foods/search"
    
    static let screen = UIScreen.main.bounds
    static let screenWidth = screen.width
    static let screenHeight = screen.height
    static let Bounds = screen
    static let Width = screenWidth
    static let Height = screenHeight
    static let MinDim = screen.minDim
    
    static let instaBlue = Color(red: 81 / 255, green: 91 / 255, blue: 212 / 255)
    static let instaPurple = Color(red: 129 / 255, green: 52 / 255, blue: 175 / 255)
    static let instaPink = Color(red: 221 / 255, green: 42 / 255, blue: 123 / 255)
    static let instaYellow = Color(red: 254 / 255, green: 218 / 255, blue: 119 / 255)
    static let instaOrange = Color(red: 245 / 255, green: 133 / 255, blue: 41 / 255)
    static let instaColors = [
                                            instaBlue,
                                            instaPurple,
                                            instaPink,
                                            instaYellow,
                                            instaOrange
                             ]
    static let instaColorsGradient = [
                                            instaPurple,
                                            instaPink,
                                            instaYellow,
                                            instaOrange,
                                            instaYellow,
                                            instaPink,
                                            instaPurple
                                     ]
    static let instaColorsLinearGradient = [
                                            instaYellow,
                                            instaPink,
                                            instaPurple,
                                            instaBlue
                                           ]
    
    static let email = "email"
    static let username = "username"
    static let fullname = "fullname"
    static let profileImageURL = "profileImageURL"
    static let uID = "uid"
    static let users = "users"
    static let followers = "followers"
    static let following = "following"
    static let userFollowers = "user-followers"
    static let userFollowing = "user-following"
    static let caption = "caption"
    static let timestamp = "timestamp"
    static let imageURL = "imageURL"
    static let likes = "likes"
    static let posts = "posts"
    static let userPosts = "user-posts"
    
    struct Units {
        struct Energy {
            static let cal = "cal"
            static let kcal = "kcal"
        }
        
        struct Mass {
            static let pg = "pg"
            static let ng = "ng"
            static let ug = "ug"
            static let mg = "mg"
            static let gm = "gm"
            static let kg = "kg"
        }
        
        struct Length {
            static let pm = "pm"
            static let ag = "ag"
            static let nm = "nm"
            static let um = "um"
            static let mm = "mm"
            static let cm = "cm"
            static let m = "m"
            static let km = "km"
        }
        
        struct Volume {
            static let pl = "pl"
            static let nl = "nl"
            static let ul = "ul"
            static let ml = "ml"
            static let cl = "cl"
            static let dl = "dl"
            static let l = "l"
            static let kl = "kl"
        }
    }
    
    struct Nutrients {
        struct Name {
            static let vitaminA = "Vitamin A"
            static let vitaminB1 = "Vitamin B1"
            static let vitaminB2 = "Vitamin B2"
            static let vitaminB3 = "Vitamin B3"
            static let vitaminB4 = "Vitamin B4"
            static let vitaminB5 = "Vitamin B5"
            static let vitaminB6 = "Vitamin B6"
            static let vitaminB7 = "Vitamin B7"
            static let vitaminB9 = "Vitamin B9"
            static let vitaminB12 = "Vitamin B12"
            static let vitaminC = "Vitamin C"
            static let vitaminD = "Vitamin D"
            static let vitaminE = "Vitamin E"
            static let vitaminK = "Vitamin K"
            
            static let calcium = "Mineral Ca"
            static let chloride = "Mineral Cl"
            static let chromium = "Mineral Cr"
            static let copper = "Mineral Cu"
            static let fluoride = "Mineral F"
            static let iodine = "Mineral I"
            static let iron = "Mineral Fe"
            static let magnesium = "Mineral Mg"
            static let manganese = "Mineral Mn"
            static let molybdenum = "Mineral Mo"
            static let phosphorous = "Mineral P"
            static let potassium = "Mineral K"
            static let selenium = "Mineral Se"
            static let sulfur = "Sulfur, S"
            static let sodium = "Mineral Na"
            static let zinc = "Mineral Zn"
            
            static let energy = "Calories"
            static let sugar = "Sugar"
            static let water = "Water"
            static let carbs = "Carbs"
            static let carbsGood = "Good Carbs"
            static let carbsBad = "Bad Carbs"
            static let fiber = "Fiber"
            static let fats = "Fats"
            static let fatsGood = "Good Fats"
            static let fatsBad = "Bad Fats"
            static let linoleicAcid = "Linoleic Acid"
            static let aLinoleicAcid = "alpha-Linoleic Acid"
            static let protein = "Protein"
            static let saturatedFat = "Saturated Fat"
            static let transFat = "Trans Fat"
            static let cholesterol = "Cholesterol"
        }
        
        struct Compound {
            static let vitaminA = "Calciferol"
            static let vitaminB1 = "Thiamin"
            static let vitaminB2 = "Riboflavin"
            static let vitaminB3 = "Niacin"
            static let vitaminB4 = "Choline"
            static let vitaminB5 = "Pantothenic"
            static let vitaminB6 = "Pyridoxine"
            static let vitaminB7 = "Biotin"
            static let vitaminB9 = "Folate"
            static let vitaminB12 = "Cobalamin"
            static let vitaminC = "Ascorbic Acid"
            static let vitaminD = "Calciferol"
            static let vitaminE = "Tocoferol"
            static let vitaminK = "Phylloquinone"
            
            static let calcium = "Calcium"
            static let chloride = "Chloride"
            static let chromium = "Chromium"
            static let copper = "Copper"
            static let fluoride = "Fluoride"
            static let iodine = "Iodine"
            static let iron = "Iron"
            static let magnesium = "Magnesium"
            static let manganese = "Manganese"
            static let molybdenum = "Molybdenum"
            static let phosphorous = "Phosphorous"
            static let potassium = "Potassium"
            static let selenium = "Selenium"
            static let sulfur = "Sulfur"
            static let sodium = "Sodium"
            static let zinc = "Zinc"
        }
    }
    
    struct Food {
        static let boostHighProteinDrink = "Boost High Protein Drink"
        static let boostVeryHighEnergyDrink = "Boost Very High Energy Drink"
        static let boostMaxMenShake = "Boost Max Men Shake"
        static let sugarWhite = "White Sugar 🍯"
        static let sugarBrown = "Brown Sugar 🍯"
        static let arugula = "Arugula ☘️"
        static let carrot = "Carrot 🥕"
        static let kale = "Kale 🥬"
    }
}

let abc = Constants.Nutrients.Compound()

