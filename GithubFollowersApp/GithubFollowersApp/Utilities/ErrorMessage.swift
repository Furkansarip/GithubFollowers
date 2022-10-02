//
//  ErrorMessage.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 25.09.2022.
//

import Foundation

enum GFError : String,Error{
    case invalidURL = "Bad URL"
    case unableToComplete = "Check your internet connection"
    case invalidResponse = "Invalid Response"
    case invalidData = "The data received from the server was invalid. Please try again!"
    case alreadyInFavorites = "User already in Favorites List"
    
}
