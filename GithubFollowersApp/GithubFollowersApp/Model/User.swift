//
//  User.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 25.09.2022.
//

import Foundation

struct User : Codable{
    let login : String
    var name : String?
    let avatarUrl : String
    var location : String?
    var bio : String?
    let publicRepos : Int
    let publicGists : Int
    let htmlUrl : String
    let following : Int
    let followers : Int
    let createdAt : String
}
