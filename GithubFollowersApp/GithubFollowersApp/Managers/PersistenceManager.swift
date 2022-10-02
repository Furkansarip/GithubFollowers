//
//  PersistenceManager.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 1.10.2022.
//

import Foundation

enum PersistenceActionType{
    case add,remove
}

enum PersistenceManager {
    
    static let defaults = UserDefaults.standard
    
    enum Keys{
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower ,actionType : PersistenceActionType,completion:@escaping(GFError?)->Void){
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrivedFavorites = favorites
                switch actionType {
                case .add:
                    guard !retrivedFavorites.contains(favorite) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    retrivedFavorites.append(favorite)
                case .remove:
                    retrivedFavorites.removeAll { $0.login == favorite.login}
                }
                completion(save(favorites: retrivedFavorites))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func retrieveFavorites(completion:@escaping(_ result: Result<[Follower],GFError>)->Void){
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
           
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        }catch{
            completion(.failure(.invalidData))
        }
    }
    
    static func save(favorites : [Follower])-> GFError?{
        do{
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch{
            return .invalidData
        }
    }
}
