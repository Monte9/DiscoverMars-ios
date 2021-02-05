//
//  Photo.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/11/21.
//

import Foundation

class Photo: NSObject, Decodable {
    let identifier: Int
    let sol: Int
    let camera: Camera
    let earthDate: String
    let url: String
    let summary: String
    let credit: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case sol = "sol"
        case camera = "camera"
        case earthDate = "earth_date"
        case url = "img_src"
    }
    
    init(identifier: Int, sol: Int, camera: Camera, earthDate: String, url: String, summary: String, credit: String) {
        self.identifier = identifier
        self.sol = sol
        self.camera = camera
        self.earthDate = earthDate
        self.url = url
        self.summary = summary
        self.credit = credit
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Identifier
        identifier = try container.decode(Int.self, forKey: .id)
        
        // Sol
        sol = try container.decode(Int.self, forKey: .sol)
        
        // Camera
        camera = try container.decode(Camera.self, forKey: .camera)
        
        // Earth Date
        let earthDateString = try container.decode(String.self, forKey: .earthDate)
        earthDate = Formatters.convertDateFormater(earthDateString)
        
        // Photo URL
        url = try container.decode(String.self, forKey: .url)
        
        // Identifier
        summary = camera.fullName
        
        // Identifier
        credit = earthDate
    }
}
