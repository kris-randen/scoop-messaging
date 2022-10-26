import Foundation

//
//  Constants.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import SwiftUI
import Foundation
//import Firebase

public struct Constants {
    public static let space = " "
    public static let colon = ":"
    public static let DEBUG = "DEBUG"
    public static let SUCESS = "SUCCESS"
    public static let FAILURE = "FAILURE"
    
    public static let screen = UIScreen.main.bounds
    public static let screenWidth = screen.width
    public static let screenHeight = screen.height
    public static let Bounds = screen
    public static let Width = screenWidth
    public static let Height = screenHeight
    public static let MinDim = screen.minDim
    
    public static let instaBlue = Color(red: 81 / 255, green: 91 / 255, blue: 212 / 255)
    public static let instaPurple = Color(red: 129 / 255, green: 52 / 255, blue: 175 / 255)
    public static let instaPink = Color(red: 221 / 255, green: 42 / 255, blue: 123 / 255)
    public static let instaYellow = Color(red: 254 / 255, green: 218 / 255, blue: 119 / 255)
    public static let instaOrange = Color(red: 245 / 255, green: 133 / 255, blue: 41 / 255)
    public static let instaColors = [
                                            instaBlue,
                                            instaPurple,
                                            instaPink,
                                            instaYellow,
                                            instaOrange
                             ]
    public static let instaColorsGradient = [
                                            instaPurple,
                                            instaPink,
                                            instaYellow,
                                            instaOrange,
                                            instaYellow,
                                            instaPink,
                                            instaPurple
                                     ]
    public static let instaColorsLinearGradient = [
                                            instaYellow,
                                            instaPink,
                                            instaPurple,
                                            instaBlue
                                           ]
    
    public static let email = "email"
    public static let username = "username"
    public static let fullname = "fullname"
    public static let profileImageURL = "profileImageURL"
    public static let uID = "uid"
    public static let users = "users"
    public static let followers = "followers"
    public static let following = "following"
    public static let userFollowers = "user-followers"
    public static let userFollowing = "user-following"
    public static let caption = "caption"
    public static let timestamp = "timestamp"
    public static let imageURL = "imageURL"
    public static let likes = "likes"
    public static let posts = "posts"
    public static let userPosts = "user-posts"
    
    public struct Nutrients {
        public struct Name {
            public static let vitaminA = "Vitamin A"
            public static let vitaminB1 = "Vitamin B1"
            public static let vitaminB2 = "Vitamin B2"
            public static let vitaminB3 = "Vitamin B3"
            public static let vitaminB4 = "Vitamin B4"
            public static let vitaminB5 = "Vitamin B5"
            public static let vitaminB6 = "Vitamin B6"
            public static let vitaminB7 = "Vitamin B7"
            public static let vitaminB9 = "Vitamin B9"
            public static let vitaminB12 = "Vitamin B12"
            public static let vitaminC = "Vitamin C"
            public static let vitaminD = "Vitamin D"
            public static let vitaminE = "Vitamin E"
            public static let vitaminK = "Vitamin K"
            
            public static let calcium = "Mineral Ca"
            public static let chloride = "Mineral Cl"
            public static let chromium = "Mineral Cr"
            public static let copper = "Mineral Cu"
            public static let fluoride = "Mineral F"
            public static let iodine = "Mineral I"
            public static let iron = "Mineral Fe"
            public static let magnesium = "Mineral Mg"
            public static let manganese = "Mineral Mn"
            public static let molybdenum = "Mineral Mo"
            public static let phosphorous = "Mineral P"
            public static let potassium = "Mineral K"
            public static let selenium = "Mineral Se"
            public static let sodium = "Mineral Na"
            public static let zinc = "Mineral Zn"
            
            public static let energy = "Calories"
            public static let sugar = "Sugar"
            public static let water = "Water"
            public static let carbs = "Carbohydrates"
            public static let fiber = "Total Fiber"
            public static let fat = "Fat"
            public static let linoleicAcid = "Linoleic Acid"
            public static let aLinoleicAcid = "alpha-Linoleic Acid"
            public static let protein = "Protein"
            public static let saturatedFat = "Saturated Fat"
            public static let transFat = "Trans Fat"
            public static let cholesterol = "Cholesterol"
        }
        
        public struct Compound {
            public static let vitaminA = "Calciferol"
            public static let vitaminB1 = "Thiamin"
            public static let vitaminB2 = "Riboflavin"
            public static let vitaminB3 = "Niacin"
            public static let vitaminB4 = "Choline"
            public static let vitaminB5 = "Pantothenic Acid"
            public static let vitaminB6 = "Pyridoxine"
            public static let vitaminB7 = "Biotin"
            public static let vitaminB9 = "Folate"
            public static let vitaminB12 = "Cobalamin"
            public static let vitaminC = "Ascorbic Acid"
            public static let vitaminD = "Calciferol"
            public static let vitaminE = "Tocoferol"
            public static let vitaminK = "Phylloquinone"
            
            public static let calcium = "Calcium"
            public static let chloride = "Chloride"
            public static let chromium = "Chromium"
            public static let copper = "Copper"
            public static let fluoride = "Fluoride"
            public static let iodine = "Iodine"
            public static let iron = "Iron"
            public static let magnesium = "Magnesium"
            public static let manganese = "Manganese"
            public static let molybdenum = "Molybdenum"
            public static let phosphorous = "Phosphorous"
            public static let potassium = "Potassium"
            public static let selenium = "Selenium"
            public static let sodium = "Sodium"
            public static let zinc = "Zinc"
        }
    }
    
    public struct Food {
        public static let boostHighProteinDrink = "Boost High Protein Nutritional Drink"
        public static let boostVeryHighEnergyDrink = "Boost Very High Energy Nutrition Drink"
        public static let boostMaxMenShake = "Boost Max Men Nutritional Shake"
    }
}

let abc = Constants.Nutrients.Compound()

