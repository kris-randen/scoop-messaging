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
    
    static let APIkeyFDC = "SFGVHByt5NbrHT8I8xQyUiAXhNUJKZOAoR783a4g"
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
    
    struct FDCunits {
        static let energy: Set = ["cal", "kcal", "kj"]
        static let mass: Set = ["kg", "g", "mg", "ug", "grm", "gram", "gm", "mcg_re", "mg_ate", "mg_gae"]
        static let iu: Set = ["iu"]
        static let length: Set = ["km", "m","cm", "mm"]
        static let volume: Set = ["l", "dl", "ml"]
    }
    
    struct DRI {
        static let energy: Double = 2000
    }
    
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
            
            static let tsp = "tea spoon"
            static let tbsp = "table spoon"
            static let oz = "ounces"
            static let cup = "cup"
        }
    }
    
    struct Nutrients {
        struct Macro {
            static let protein: Nutrient.Macro = .protein
            static let energy: Nutrient.Macro = .energy
            static let fats: Nutrient.Macro = .fats
            static let carbs: Nutrient.Macro = .carbs
            static let sugar: Nutrient.Macro = .sugar
            static let fiber: Nutrient.Macro = .fiber
        }
        
        struct Micro {
            static let vitaminA: Nutrient.Micro.Vitamin = .a
            static let vitaminAiu: Nutrient.Micro.Vitamin = .aiu
            static let vitaminC: Nutrient.Micro.Vitamin = .c
            static let vitaminD: Nutrient.Micro.Vitamin = .d
            static let vitaminDiu: Nutrient.Micro.Vitamin = .diu
            static let vitaminE: Nutrient.Micro.Vitamin = .e
            static let vitaminEiu: Nutrient.Micro.Vitamin = .eiu
            static let vitaminK: Nutrient.Micro.Vitamin = .k
            static let vitaminB1: Nutrient.Micro.Vitamin = .b1
            static let vitaminB2: Nutrient.Micro.Vitamin = .b2
            static let vitaminB3: Nutrient.Micro.Vitamin = .b3
            static let vitaminB4: Nutrient.Micro.Vitamin = .b4
            static let vitaminB5: Nutrient.Micro.Vitamin = .b5
            static let vitaminB6: Nutrient.Micro.Vitamin = .b6
            static let vitaminB7: Nutrient.Micro.Vitamin = .b7
            static let vitaminB9: Nutrient.Micro.Vitamin = .b9
            static let vitaminB12: Nutrient.Micro.Vitamin = .b12
            
            static let calcium: Nutrient.Micro.Mineral = .Ca
            static let chloride: Nutrient.Micro.Mineral = .Cl
            static let chromium: Nutrient.Micro.Mineral = .Cr
            static let copper: Nutrient.Micro.Mineral = .Cu
            static let fluoride: Nutrient.Micro.Mineral = .F
            static let iodine: Nutrient.Micro.Mineral = .I
            static let iron: Nutrient.Micro.Mineral = .Fe
            static let magnesium: Nutrient.Micro.Mineral = .Mg
            static let manganese: Nutrient.Micro.Mineral = .Mn
            static let molybdenum: Nutrient.Micro.Mineral = .Mo
            static let phosphorous: Nutrient.Micro.Mineral = .P
            static let potassium: Nutrient.Micro.Mineral = .K
            static let selenium: Nutrient.Micro.Mineral = .Se
            static let sodium: Nutrient.Micro.Mineral = .Na
            static let zinc: Nutrient.Micro.Mineral = .Zn
//            static let sulfur: Nutrient.Micro.Mineral = .S
        }
        
        
        struct Name {
            static let vitaminA = "Vitamin A"
            static let vitaminAiu = "Vitamin A, IU"
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
            static let vitaminDiu = "Vitamin D, IU"
            static let vitaminE = "Vitamin E"
            static let vitaminEiu = "Vitamin E, IU"
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
            
            static let calories = "Calories"
            static let energy = "Energy"
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
            
            static let macros = [
                Name.calories,      //"Calories"
                Name.energy,        //"Energy"
                Name.sugar,         //"Sugar"
                Name.water,         //"Water"
                Name.carbs,         //"Carbs"
                Name.carbsGood,     //"Good Carbs"
                Name.carbsBad,      //"Bad Carbs"
                Name.fiber,         //"Fiber"
                Name.fats,          //"Fats"
                Name.fatsGood,      //"Good Fats"
                Name.fatsBad,       //"Bad Fats"
                Name.linoleicAcid,  //"Linoleic Acid"
                Name.aLinoleicAcid, //"alpha-Linoleic Acid"
                Name.protein,       //"Protein"
                Name.saturatedFat,  //"Saturated Fat"
                Name.transFat,      //"Trans Fat"
                Name.cholesterol    //"Cholesterol"
            ]
                .map{$0.lowercased()}.set
            
            static let vitamins = [
                Name.vitaminA,      //"Vitamin A"
                Name.vitaminB1,     //"Vitamin B1"
                Name.vitaminB2,     //"Vitamin B2"
                Name.vitaminB3,     //"Vitamin B3"
                Name.vitaminB4,     //"Vitamin B4"
                Name.vitaminB5,     //"Vitamin B5"
                Name.vitaminB6,     //"Vitamin B6"
                Name.vitaminB7,     //"Vitamin B7"
                Name.vitaminB9,     //"Vitamin B9"
                Name.vitaminB12,    //"Vitamin B12"
                Name.vitaminC,      //"Vitamin C"
                Name.vitaminD,      //"Vitamin D"
                Name.vitaminE,      //"Vitamin E"
                Name.vitaminK       //"Vitamin K"
            ]
                .map{$0.lowercased()}.set
            
            static let minerals = [
                Name.calcium,
                Name.chloride,
                Name.chromium,
                Name.copper,
                Name.fluoride,
                Name.iodine,
                Name.iron,
                Name.magnesium,
                Name.manganese,
                Name.molybdenum,
                Name.phosphorous,
                Name.potassium,
                Name.selenium,
                Name.sulfur,
                Name.sodium,
                Name.zinc
            ]
                .map{$0.lowercased()}.set
        }
        
        struct FDCmap {
            static let macro = [
                FDCid.protein: Macro.protein,
                FDCid.energy: Macro.energy,
                FDCid.fats: Macro.fats,
                FDCid.carbs: Macro.carbs,
                FDCid.sugar: Macro.sugar,
                FDCid.fiber: Macro.fiber
            ]
            
            static let vitamin = [
                FDCid.vitaminA: Micro.vitaminA,
//                FDCid.vitaminAiu: Micro.vitaminAiu,
                FDCid.vitaminC: Micro.vitaminC,
                FDCid.vitaminD: Micro.vitaminD,
//                FDCid.vitaminDiu: Micro.vitaminDiu,
                FDCid.vitaminE: Micro.vitaminE,
//                FDCid.vitaminEiu: Micro.vitaminEiu,
                FDCid.vitaminK: Micro.vitaminK,
                FDCid.vitaminB1: Micro.vitaminB1,
                FDCid.vitaminB2: Micro.vitaminB2,
                FDCid.vitaminB3: Micro.vitaminB3,
                FDCid.vitaminB4: Micro.vitaminB4,
                FDCid.vitaminB5: Micro.vitaminB5,
                FDCid.vitaminB6: Micro.vitaminB6,
                FDCid.vitaminB7: Micro.vitaminB7,
                FDCid.vitaminB9: Micro.vitaminB9,
                FDCid.vitaminB12: Micro.vitaminB12
            ]
            
            static let mineral = [
                FDCid.calcium: Micro.calcium,
                FDCid.chloride: Micro.chloride,
                FDCid.chromium: Micro.chromium,
                FDCid.copper: Micro.copper,
                FDCid.fluoride: Micro.fluoride,
                FDCid.iodine: Micro.iodine,
                FDCid.iron: Micro.iron,
                FDCid.magnesium: Micro.magnesium,
                FDCid.manganese: Micro.manganese,
                FDCid.molybdenum: Micro.molybdenum,
                FDCid.phosphorous: Micro.phosphorous,
                FDCid.potassium: Micro.potassium,
                FDCid.selenium: Micro.selenium,
                FDCid.sodium: Micro.sodium,
                FDCid.zinc: Micro.zinc
//                FDCid.sulfur: Micro.S
            ]
        }
        
        struct FDCid {
            static let protein = 1003
            static let energy = 1008
            static let fats = 1004
            static let carbs = 1005
            static let sugar = 2000
            static let fiber = 1079
            
            static let vitaminA = 1106
            static let vitaminAiu = 1104
            static let vitaminC = 1162
            static let vitaminD = 1114
            static let vitaminDiu = 1110
            static let vitaminE = 1109
            static let vitaminEiu = 1124
            static let vitaminK = 1185
            static let vitaminB1 = 1165
            static let vitaminB2 = 1166
            static let vitaminB3 = 1167
            static let vitaminB4 = 1180
            static let vitaminB5 = 1170
            static let vitaminB6 = 1175
            static let vitaminB7 = 1176
            static let vitaminB9 = 1177
            static let vitaminB12 = 1178
            
            static let calcium = 1087
            static let chloride = 1088
            static let iron = 1089
            static let magnesium = 1090
            static let phosphorous = 1091
            static let potassium = 1092
            static let sodium = 1093
            static let sulphur = 1094
            static let zinc = 1095
            static let chromium = 1096
            static let copper = 1098
            static let fluoride = 1099
            static let iodine = 1100
            static let manganese = 1101
            static let molybdenum = 1102
            static let selenium = 1103
        }
        
        struct FDCname {
            static let vitaminAiu = "Vitamin A, IU"
            static let vitaminArae = "Vitamin A, RAE"
            static let vitaminEalphat = "Vitamin E (alpha-tocopherol)"
            static let vitaminD23iu = "Vitamin D (D2 + D3), International Units"
            static let vitaminD2 = "Vitamin D2 (ergocalciferol)"
            static let vitaminD3 = "Vitamin D3 (cholecalciferol)"
            static let vitaminD23 = "Vitamin D (D2 + D3)"
            static let vitaminElabel = "Vitamin E (label entry primarily)"
            static let vitaminAre = "Vitamin A, RE"
            static let vitaminE = "Vitamin E"
            static let vitaminCtotal = "Vitamin C, total ascorbic acid"
            static let vitaminCred = "Vitamin C, reduced ascorbic acid"
            static let vitaminCdehyd = "Vitamin C, dehydro ascorbic acid"
            static let vitaminB6pyrAlc = "Vitamin B-6, pyridoxine, alcohol form"
            static let vitaminB6pyrAld = "Vitamin B-6, pyridoxal, aldehyde form"
            static let vitaminB6pyrAmi = "Vitamin B-6, pyridoxamine, amine form"
            static let vitaminB6n = "Vitamin B-6, N411 + N412 +N413"
            static let vitaminB6 = "Vitamin B-6"
            static let vitaminB12 = "Vitamin B-12"
            static let vitaminKmenaq = "Vitamin K (Menaquinone-4)"
            static let vitaminKdihyd = "Vitamin K (Dihydrophylloquinone)"
            static let vitaminKphyllo = "Vitamin K (phylloquinone)"
            static let vitaminCadd = "Vitamin C, added"
            static let vitaminEadd = "Vitamin E, added"
            static let vitaminB12add = "Vitamin B-12, added"
            static let vitaminCint = "Vitamin C, intrinsic"
            static let vitaminEint = "Vitamin E, intrinsic"
            static let vitaminB12int = "Vitamin B-12, intrinsic"
            static let vitaminD4 = "Vitamin D4"
            static let vitaminB1add = "Thiamin, added"
            static let vitaminB2add = "Riboflavin, added"
            static let vitaminB3add = "Niacin, added"
            static let vitaminB1int = "Thiamin, intrinsic"
            static let vitaminB2int = "Riboflavin, intrinsic"
            static let vitaminB3int = "Niacin, intrinsic"
            static let vitaminB3 = "Niacin"
            static let vitaminB3tryp = "Niacin from tryptophan, determined"
            static let vitaminB3eqn = "Niacin equivalent N406 +N407"
            static let vitaminB5 = "Pantothenic acid"
            static let vitaminB7 = "Biotin"
            static let vitaminB9total = "Folate, total"
            static let vitaminB9free = "Folate, free"
            static let vitaminB4total = "Choline, total"
                
            static let calcium = "Calcium, Ca"
            static let chloride = "Chlorine, Cl"
            static let chromium = "Chromium, Cr"
            static let copper = "Copper, Cu"
            static let fluoride = "Fluoride, F"
            static let iodine = "Iodine, I"
            static let iron = "Iron, Fe"
            static let magnesium = "Magnesium, Mg"
            static let manganese = "Manganese, Mn"
            static let molybdenum = "Molybdenum, Mo"
            static let phosphorous = "Mineral P"
            static let potassium = "Mineral K"
            static let selenium = "Selenium, Se"
            static let sulfur = "Sulfur, S"
            static let sodium = "Sodium, Na"
            static let zinc = "Zinc, Zn"
            
            static let calories = "Calories"
            static let energy = "Energy"
            static let sugar = "Sugar"
            static let water = "Water"
            static let carbs = "Carbohydrate, by difference"
            static let carbsSum = "Carbohydrate, by summation"
            static let carbsGood = "Good Carbs"
            static let carbsBad = "Bad Carbs"
            static let fiber = "Fiber, total dietary"
            static let fats = "Total lipid (fat)"
            static let fatsGood = "Good Fats"
            static let fatsBad = "Bad Fats"
            static let linoleicAcid = "Linoleic Acid"
            static let aLinoleicAcid = "alpha-Linoleic Acid"
            static let protein = "Protein"
            static let saturatedFat = "Saturated Fat"
            static let transFat = "Trans Fat"
            static let cholesterol = "Cholesterol"
            
            static let macros = [
                FDCname.calories,      //"Calories"
                FDCname.energy,        //"Energy"
                FDCname.sugar,         //"Sugar"
                FDCname.water,         //"Water"
                FDCname.carbs,         //"Carbs"
                FDCname.carbsGood,     //"Good Carbs"
                FDCname.carbsBad,      //"Bad Carbs"
                FDCname.fiber,         //"Fiber"
                FDCname.fats,          //"Fats"
                FDCname.fatsGood,      //"Good Fats"
                FDCname.fatsBad,       //"Bad Fats"
                FDCname.linoleicAcid,  //"Linoleic Acid"
                FDCname.aLinoleicAcid, //"alpha-Linoleic Acid"
                FDCname.protein,       //"Protein"
                FDCname.saturatedFat,  //"Saturated Fat"
                FDCname.transFat,      //"Trans Fat"
                FDCname.cholesterol    //"Cholesterol"
            ]
                .map{$0.lowercased()}.set
            
            static let vitamins = [
                FDCname.vitaminAiu,     // "Vitamin A, IU"
                FDCname.vitaminArae,    // "Vitamin A, RAE"
                FDCname.vitaminEalphat, // "Vitamin E (alpha-tocopherol)"
                FDCname.vitaminD23iu,   // "Vitamin D (D2 + D3), International Units"
                FDCname.vitaminD2,      // "Vitamin D2 (ergocalciferol)"
                FDCname.vitaminD3,      // "Vitamin D3 (cholecalciferol)"
                FDCname.vitaminD23,     // "Vitamin D (D2 + D3)"
                FDCname.vitaminElabel,  // "Vitamin E (label entry primarily)"
                FDCname.vitaminAre,     // "Vitamin A, RE"
                FDCname.vitaminE,       // "Vitamin E"
                FDCname.vitaminCtotal,  // "Vitamin C, total ascorbic acid"
                FDCname.vitaminCred,    // "Vitamin C, reduced ascorbic acid"
                FDCname.vitaminCdehyd,  // "Vitamin C, dehydro ascorbic acid"
                FDCname.vitaminB6pyrAlc,// "Vitamin B-6, pyridoxine, alcohol form"
                FDCname.vitaminB6pyrAld,// "Vitamin B-6, pyridoxal, aldehyde form"
                FDCname.vitaminB6pyrAmi,// "Vitamin B-6, pyridoxamine, amine form"
                FDCname.vitaminB6n,     // "Vitamin B-6, N411 + N412 +N413"
                FDCname.vitaminB6,      // "Vitamin B-6"
                FDCname.vitaminB12,     // "Vitamin B-12"
                FDCname.vitaminKmenaq,  // "Vitamin K (Menaquinone-4)"
                FDCname.vitaminKdihyd,  // "Vitamin K (Dihydrophylloquinone)"
                FDCname.vitaminKphyllo, // "Vitamin K (phylloquinone)"
                FDCname.vitaminCadd,    // "Vitamin C, added"
                FDCname.vitaminEadd,    // "Vitamin E, added"
                FDCname.vitaminB12add,  // "Vitamin B-12, added"
                FDCname.vitaminCint,    // "Vitamin C, intrinsic"
                FDCname.vitaminEint,    // "Vitamin E, intrinsic"
                FDCname.vitaminB12int,  // "Vitamin B-12, intrinsic"
                FDCname.vitaminD4,      // "Vitamin D4"
                FDCname.vitaminB1add,   // "Thiamin, added"
                FDCname.vitaminB2add,   // "Riboflavin, added"
                FDCname.vitaminB3add,   // "Niacin, added"
                FDCname.vitaminB1int,   // "Thiamin, intrinsic"
                FDCname.vitaminB2int,   // "Riboflavin, intrinsic"
                FDCname.vitaminB3int,   // "Niacin, intrinsic"
                FDCname.vitaminB3,      // "Niacin"
                FDCname.vitaminB3tryp,  // "Niacin from tryptophan, determined"
                FDCname.vitaminB3eqn,   // "Niacin equivalent N406 +N407"
                FDCname.vitaminB5,      // "Pantothenic acid"
                FDCname.vitaminB7,      // "Biotin"
                FDCname.vitaminB9total, // "Folate, total"
                FDCname.vitaminB9free,  // "Folate, free"
                FDCname.vitaminB4total, // "Choline, total"
            ]
                .map{$0.lowercased()}.set
            
            static let minerals = [
                FDCname.calcium,
                FDCname.chloride,
                FDCname.chromium,
                FDCname.copper,
                FDCname.fluoride,
                FDCname.iodine,
                FDCname.iron,
                FDCname.magnesium,
                FDCname.manganese,
                FDCname.molybdenum,
                FDCname.phosphorous,
                FDCname.potassium,
                FDCname.selenium,
                FDCname.sulfur,
                FDCname.sodium,
                FDCname.zinc
            ]
                .map{$0.lowercased()}.set
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

