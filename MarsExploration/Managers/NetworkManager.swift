//
//  NetworkManager.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/8/21.
//

// https://github.com/chrisccerami/mars-photo-api

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    /// Fetches the mission manifest for all the `Rover` instances
    /// - Parameter completionHandler: A completion handler that returns a success or a failure result
    func fetchMissions(completionHandler: @escaping ((Result<[Mission], Error>) -> Void)) {
        let missionsDispatchGroup = DispatchGroup()
        var missions = [Mission]()
        
        for rover in Rover.allCases {
            missionsDispatchGroup.enter()
            
            fetchManifest(for: rover) { result in
                switch result {
                case .success(let mission):
                    missions.append(mission)
                case .failure(let error):
                    print("Failed to fetch mission manifest for \(rover): \(error)")
                }
                missionsDispatchGroup.leave()
            }
        }
        
        missionsDispatchGroup.notify(queue: .main) {
            if missions.count == Rover.allCases.count {
                completionHandler(.success(missions))
            } else {
                completionHandler(.failure(NetworkManagerError.missingData))
            }
        }
    }
    
    /// Fetch the mission manifest for a given `Rover`
    /// - Parameters:
    ///   - rover: A `Rover` instance to fetch the mission manifest
    ///   - completionHandler: A completion handler that returns a success or a failure result
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
                
                DispatchQueue.main.async {
                    completionHandler(.success(mission))
                }
            } catch {
                completionHandler(.failure(error))
            }
        }

        task.resume()
    }
    
    /// Fetches the photos for a given `Rover` instance and for a specific `Sol` date
    /// - Parameters:
    ///   - rover: A `Rover` instance for the photos
    ///   - sol: A `Sol` date for the photos
    ///   - completionHandler: A completion handler that returns a success or a failure result
    func fetchPhotos(for rover: Rover, and sol: Int, completionHandler: @escaping ((Result<[Photo], Error>) -> Void)) {
        let url = URL(string: RequestPath.baseURL + RequestPath.roversURL + rover.rawValue + RequestPath.photosURL + "?" + "sol=\(sol)" + "&" + RequestPath.apiKey)!
        
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
                      let photosJSON = jsonData["photos"] else {
                    completionHandler(.failure(NetworkManagerError.missingData))
                    return
                }

                let photosData = try JSONSerialization.data(withJSONObject: photosJSON, options: .prettyPrinted)
                let photos = try JSONDecoder().decode([Photo].self, from: photosData)

                DispatchQueue.main.async {
                    completionHandler(.success(photos))
                }
            } catch {
                completionHandler(.failure(error))
            }
        }

        task.resume()
    }
    
}
