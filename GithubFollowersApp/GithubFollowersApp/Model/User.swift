//
//  User.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 25.09.2022.
//

import Foundation

struct User {
    var login : String
    var name : String?
    var avatarUrl : String
    var location : String?
    var bio : String?
    var publicRepos : Int
    var publicGists : Int
    var htmlUrl : String
    var following : Int
    var followers : Int
    var createdAt : String
}
