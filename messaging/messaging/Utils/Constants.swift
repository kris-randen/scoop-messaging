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
    
    static let screen = UIScreen.main.bounds
    static let screenWidth = screen.width
    static let screenHeight = screen.height
    
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
    
    
//    static let collectionUsers = Firestore.firestore().collection(users)
//    static let collectionFollowers = Firestore.firestore().collection(followers)
//    static let collectionFollowing = Firestore.firestore().collection(following)
//    static let collectionPosts = Firestore.firestore().collection(posts)
}
