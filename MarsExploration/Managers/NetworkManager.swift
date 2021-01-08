//
//  NetworkManager.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/8/21.
//

// https://github.com/chrisccerami/mars-photo-api

import Foundation

enum Rover: String {
    case curiosity
    case opportunity
    case spirit
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchManifest(for rover: Rover, completionHandler: @escaping ((Result<Mission, Error>) -> Void)) {
        let url = URL(string: RequestPath.baseURL + RequestPath.manifestURL + rover.rawValue + "?" + RequestPath.apiKey)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard (response as? HTTPURLResponse) != nil else {
                completionHandler(.failure(NetworkManagerError.noResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(NetworkManagerError.missingData))
                return
            }
            
            do {
                guard let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let missionJSON = jsonData["photo_manifest"] as? [String: Any] else {
                    completionHandler(.failure(NetworkManagerError.missingData))
                    return
                }
                
                let missionData = try JSONSerialization.data(withJSONObject: missionJSON, options: .prettyPrinted)
                let mission = try JSONDecoder().decode(Mission.self, from: missionData)
                completionHandler(.success(mission))
            } catch {
                completionHandler(.failure(error))
            }
        }

        task.resume()
    }
}
