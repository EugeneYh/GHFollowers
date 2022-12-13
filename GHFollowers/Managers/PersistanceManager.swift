//
//  PersistanceManager.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 23.11.2022.
//

import Foundation

enum PersistanceActionType {
    case save,  remove
}

enum PersistanceManager {
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static private let defaults = UserDefaults.standard
    
    static func updateWith(favorite: Follower, actionType: PersistanceActionType, completion: @escaping (GFError?) -> Void) {
        
        retreiveFavorites { result in
            switch result {
                case .success(var favorites):
                    
                    switch actionType {
                        case .save:
                            guard !favorites.contains(favorite) else {
                                completion(.alreadyInFavorites)
                                return
                            }
                            favorites.append(favorite)
                        case.remove:
                            favorites.removeAll { $0.login == favorite.login }
                    }
                completion(saveToFavorites(favorites: favorites))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func retreiveFavorites(completion: @escaping(Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToGetFavorites))
        } 
    }
    
    static func saveToFavorites(favorites: [Follower]) -> GFError? {
        do{
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToGetFavorites
        }
     }
}
