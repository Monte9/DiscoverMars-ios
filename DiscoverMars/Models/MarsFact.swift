//
//  MarsFact.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 2/7/21.
//

import Foundation

enum MarsFact: String, CaseIterable {
    case size
    case mass
    case volume
    case density
    case structure
    case distance
    case speed
    case year
    case season
    case day
    
    init(fromRawValue: String) {
        self = MarsFact(rawValue: fromRawValue) ?? .size
    }
    
    func title() -> String {
        switch self {
        case .size:
            return "Size"
        case .mass:
            return "Mass"
        case .volume:
            return "Volume"
        case .density:
            return "Density"
        case .structure:
            return "Structure"
        case .distance:
            return "Distance"
        case .speed:
            return "Speed"
        case .year:
            return "Year"
        case .season:
            return "Season"
        case .day:
            return "Day"
        }
    }
    
    func subtitle() -> String {
        switch self {
        case .size:
            return "Equatorial diameter"
        case .mass:
            return "Amount of matter"
        case .volume:
            return "Amount of space occupied"
        case .density:
            return "Average"
        case .structure:
            return "Average"
        case .distance:
            return "Average distance from orbit path to the Sun"
        case .speed:
            return "Velocity relative to the Sun"
        case .year:
            return "Approximately"
        case .season:
            return "Approximate tilt"
        case .day:
            return "Approximately"
        }
    }
    
    func description() -> String {
        switch self {
        case .size:
            return ""
        case .mass:
            return ""
        case .volume:
            return "Mars has about 15% of Earth’s volume. To fill Earth’s volume, it would take over 6 Mars volumes"
        case .density:
            return "Mars is about 71% as dense as Earth"
        case .structure:
            return "Scientists are not yet certain if the core of Mars is solid, liquid, or in two distinct sublayers, like Earth’s. Future measurements will tell us more."
        case .distance:
            return ""
        case .speed:
            return ""
        case .year:
            return ""
        case .season:
            return "Similar tilts mean that Mars has seasons just like Earth. But, since mars’ year is almost twice as long, its seasons are longer too. Because of Mars’ elliptical orbit, some seasons are longer than others."
        case .day:
            return ""
        }
    }
    
    func imageName() -> String {
        switch self {
        case .size:
            return "mars.fact.size"
        case .mass:
            return "mars.fact.mass"
        case .volume:
            return "mars.fact.size"
        case .density:
            return "mars.fact.size"
        case .structure:
            return "mars.fact.size"
        case .distance:
            return "mars.fact.size"
        case .speed:
            return "mars.fact.size"
        case .year:
            return "mars.fact.size"
        case .season:
            return "mars.fact.size"
        case .day:
            return "mars.fact.size"
        }
    }
}
