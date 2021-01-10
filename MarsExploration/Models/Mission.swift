//
//  Mission.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/8/21.
//

import Foundation

class Mission: NSObject, Decodable {
    
    // Mission Overview
    let overview: String
    let missionName: String
    let roverName: String
    let roverImage: String
    
    // Misson Status
    let status: String
    let maxDate: String
    
    // Launch Summary
    let launchDate: String
    let launchVehicle: String
    let launchLocation: String
    
    // Landing Summary
    let landingDate: String
    let landingSite: String
    
    // Photo Summary
    let maxSol: Int
    let totalPhotos: Int
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case status = "status"
        case maxDate = "max_date"
        case launchDate = "launch_date"
        case landingDate = "landing_date"
        case maxSol = "max_sol"
        case totalPhotos = "total_photos"
    }
    
    init(overview: String, missionName: String, roverName: String, roverImage: String,
         status: String, maxDate: String,
         launchDate: String, launchVehicle: String, launchLocation: String,
         landingDate: String, landingSite: String,
         maxSol: Int, totalPhotos: Int) {
        self.overview = overview
        self.missionName = missionName
        self.roverName = roverName
        self.roverImage = roverImage
        self.status = status
        self.maxDate = maxDate
        self.launchDate = launchDate
        self.launchVehicle = launchVehicle
        self.launchLocation = launchLocation
        self.landingDate = landingDate
        self.landingSite = landingSite
        self.maxSol = maxSol
        self.totalPhotos = totalPhotos
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Rover Name
        roverName = try container.decode(String.self, forKey: .name)
        
        // Rover Type
        let rover = Rover.init(fromRawValue: roverName.lowercased())
        
        // Mission Overview
        overview = rover.missionOverview()
        
        // Mission Name based on Rover
        missionName = rover.missionName()
        
        // Rover Image based on Rover
        roverImage = rover.roverImage()
        
        // Status
        let statusString = try container.decode(String.self, forKey: .status)
        status = statusString.titleCase()
        
        // Max Date
        let maxDateString = try container.decode(String.self, forKey: .maxDate)
        maxDate = Formatters.convertDateFormater(maxDateString)
        
        // Launch Date
        let launchDateString = try container.decode(String.self, forKey: .launchDate)
        launchDate = Formatters.convertDateFormater(launchDateString)
        
        // Launch Vehicle
        launchVehicle = rover.launchVehicle()
        
        // Launch Location
        launchLocation = rover.launchLocation()
        
        // Landing Date
        let landingDateString = try container.decode(String.self, forKey: .landingDate)
        landingDate = Formatters.convertDateFormater(landingDateString)
        
        // Landing Site
        landingSite = rover.landingSite()
        
        // Max Sol
        maxSol = try container.decode(Int.self, forKey: .maxSol)
        
        // Total Photos
        totalPhotos = try container.decode(Int.self, forKey: .totalPhotos)
    }
    
}
