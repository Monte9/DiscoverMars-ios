//
//  Photo.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/11/21.
//

import Foundation

class Photo: NSObject, Decodable {
    let sol: Int
    let camera: Camera
    let earthDate: String
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case sol = "sol"
        case camera = "camera"
        case earthDate = "earth_date"
        case url = "img_src"
    }
    
    init(sol: Int, camera: Camera, earthDate: String, url: String) {
        self.sol = sol
        self.camera = camera
        self.earthDate = earthDate
        self.url = url
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Sol
        sol = try container.decode(Int.self, forKey: .sol)
        
        // Camera
        camera = try container.decode(Camera.self, forKey: .camera)
        
        // Earth Date
        earthDate = try container.decode(String.self, forKey: .earthDate)
        
        // Photo URL
        url = try container.decode(String.self, forKey: .url)
    }
}
