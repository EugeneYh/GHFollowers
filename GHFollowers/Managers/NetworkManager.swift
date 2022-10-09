//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 07.10.2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    let baseURL = "https://api.github.com/users/"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping ([Follower]?,  String?) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=100"
        print(endpoint)
        
        guard let url = URL(string: endpoint) else {
            completion(nil, "This username created an invalid request. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _  = error {
                completion(nil, "Unable to your request. Please check your internet connection")
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "Wrong data. Please try again")
                return
            }
            
            guard let data = data else {
                completion(nil, "Invalid data. Please try again")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil)
            } catch {
                completion(nil, "Invalid data. Please try again")
            }
        }
        
        task.resume()
        
    }
}
