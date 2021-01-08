//
//  Mission.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/8/21.
//

import Foundation

enum Rover: String, CaseIterable {
    case curiosity
    case opportunity
    case spirit
    
    func missionName() -> String {
        switch self {
        case .curiosity:
            return "Mars Science Laboratory"
        case .opportunity:
            return "Mars Exploration Rover - Opportunity"
        case .spirit:
            return "Mars Exploration Rover - Spirit"
        }
    }
}

class Mission: NSObject, Decodable {
    let missionName: String
    let roverName: String
    let landingDate: String
    let launchDate: String
    let status: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status = "status"
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
    }
    
    init(missionName: String, roverName: String, landingDate: String, launchDate: String, status: String, maxSol: Int, maxDate: String, totalPhotos: Int) {
        self.missionName = missionName
        self.roverName = roverName
        self.landingDate = landingDate
        self.launchDate = launchDate
        self.status = status
        self.maxSol = maxSol
        self.maxDate = maxDate
        self.totalPhotos = totalPhotos
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        roverName = try container.decode(String.self, forKey: .name)
        
        // Get the Mission Name based on the Rover
        if let rover = Rover.init(rawValue: roverName.lowercased()) {
            missionName = rover.missionName()
        } else {
            missionName = "Mission"
        }
        
        landingDate = try container.decode(String.self, forKey: .landingDate)
        launchDate = try container.decode(String.self, forKey: .launchDate)
        status = try container.decode(String.self, forKey: .status)
        maxSol = try container.decode(Int.self, forKey: .maxSol)
        maxDate = try container.decode(String.self, forKey: .maxDate)
        totalPhotos = try container.decode(Int.self, forKey: .totalPhotos)
    }
    
}
