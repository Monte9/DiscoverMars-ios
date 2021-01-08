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
            return "Mars Exploration Rovers"
        case .spirit:
            return "Mars Exploration Rovers"
        }
    }
    
    func roverImage() -> String {
        switch self {
        case .curiosity:
            return "https://mars.nasa.gov/system/feature_items/images/6037_msl_banner.jpg"
        case .opportunity:
            return "https://www.extremetech.com/wp-content/uploads/2016/01/Opportunity.jpg"
        case .spirit:
            return "https://www.universetoday.com/wp-content/uploads/2008/10/five_years_on_mars-4_10240768.jpg"
        }
    }
}

class Mission: NSObject, Decodable {
    
    let roverImage: String
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
    
    init(roverImage: String, missionName: String, roverName: String, landingDate: String, launchDate: String, status: String, maxSol: Int, maxDate: String, totalPhotos: Int) {
        self.roverImage = roverImage
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
        
        // Get the Rover Image based on the Rover
        if let rover = Rover.init(rawValue: roverName.lowercased()) {
            roverImage = rover.roverImage()
        } else {
            roverImage = "https://mars.nasa.gov/system/feature_items/images/6037_msl_banner.jpg"
        }
        
        landingDate = try container.decode(String.self, forKey: .landingDate)
        launchDate = try container.decode(String.self, forKey: .launchDate)
        status = try container.decode(String.self, forKey: .status)
        maxSol = try container.decode(Int.self, forKey: .maxSol)
        maxDate = try container.decode(String.self, forKey: .maxDate)
        totalPhotos = try container.decode(Int.self, forKey: .totalPhotos)
    }
    
}
