//
//  NetworkManager.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 25.09.2022.
//

import Foundation
import UIKit

struct NetworkManager {
    private let baseURL = "https://api.github.com"
    let cache = NSCache<NSString,UIImage>()
    static let shared = NetworkManager()
    private init(){}
    
    func getFollowers(for username:String,page:Int,completion:@escaping(_ result:Result<[Follower],GFError>)->Void){
        let endpoint = baseURL + "/users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            }catch{
                completion(.failure(.invalidData))
            }
        
        }
        task.resume()
    }
    
    func getUserInfo(for username:String,completion:@escaping(_ result:Result<User,GFError>)->Void){
        let endpoint = baseURL + "/users/\(username)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode(User.self, from: data)
                completion(.success(followers))
            }catch{
                completion(.failure(.invalidData))
            }
        
        }
        task.resume()
    }
}
