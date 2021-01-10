//
//  Formatters.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/10/21.
//

import Foundation

class Formatters {
    
    static func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        
        // Format String: 2021-01-09
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        
        // Format String: Jul 21, 2016
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return  dateFormatter.string(from: date!)
    }
    
}
