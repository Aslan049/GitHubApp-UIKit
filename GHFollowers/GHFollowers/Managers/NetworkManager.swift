//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Aslan Korkmaz on 1.07.2025.
//

import Foundation

class NetworkManager {
    static let shared   = NetworkManager()
    let baseURL         = "https://api.github.com/users"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseURL + "/\(username)/followers?page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, "This username created an invalid request.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(nil, "Unable to complete your request.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the serves.")
                return
            }
            
            guard let data = data else {
                completed(nil, "The data received from the server was invalid.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, "The data received from the server was invalid.")
            }
        }
        task.resume()
    }
}
