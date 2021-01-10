//
//  Camera.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/11/21.
//

import Foundation

class Camera: NSObject, Decodable {
    let name: String
    let fullName: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case fullName = "full_name"
    }
    
    init(name: String, fullName: String) {
        self.name = name
        self.fullName = fullName
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Camera Name
        name = try container.decode(String.self, forKey: .name)
        
        // Camera Full Name
        fullName = try container.decode(String.self, forKey: .fullName)
    }
    
}
