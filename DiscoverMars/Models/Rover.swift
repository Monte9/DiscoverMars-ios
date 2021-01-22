//
//  Rover.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/11/21.
//

import Foundation

enum Rover: String, CaseIterable {
    case curiosity
    case opportunity
    case spirit
    
    init(fromRawValue: String) {
        self = Rover(rawValue: fromRawValue) ?? .curiosity
    }
    
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
    
    func launchVehicle() -> String {
        switch self {
        case .curiosity:
            return "Atlas V 541"
        case .opportunity:
            return "Delta II 7925H (Delta II Heavy)"
        case .spirit:
            return "Delta II 7925"
        }
    }
    
    func launchLocation() -> String {
        switch self {
        case .curiosity:
            return "Cape Canaveral Air Force Station, Florida"
        case .opportunity:
            return "Cape Canaveral Air Force Station, Florida"
        case .spirit:
            return "Cape Canaveral Air Force Station, Florida"
        }
    }
    
    func landingSite() -> String {
        switch self {
        case .curiosity:
            return "Gale Crater, Mars"
        case .opportunity:
            return "Meridiani Planum, Mars"
        case .spirit:
            return "Gusev Crater, Mars"
        }
    }
    
    func missionOverview() -> String {
        switch self {
        case .curiosity:
            return "Curiosity set out to answer the question: Did Mars ever have the right environmental conditions to support small life forms called microbes? Early in its mission, Curiosity's scientific tools found chemical and mineral evidence of past habitable environments on Mars. It continues to explore the rock record from a time when Mars could have been home to microbial life."
        case .opportunity:
            return "In January 2004, two robotic geologists named Spirit and Opportunity landed on opposite sides of the red planet. With far greater mobility than the 1997 Mars Pathfinder rover, these robotic explorers have trekked for miles across the Martian surface, conducting field geology and making atmospheric observations. Carrying identical, sophisticated sets of science instruments, both rovers have found evidence of ancient Martian environments where intermittently wet and habitable conditions existed."
        case .spirit:
            return "In January 2004, two robotic geologists named Spirit and Opportunity landed on opposite sides of the red planet. With far greater mobility than the 1997 Mars Pathfinder rover, these robotic explorers have trekked for miles across the Martian surface, conducting field geology and making atmospheric observations. Carrying identical, sophisticated sets of science instruments, both rovers have found evidence of ancient Martian environments where intermittently wet and habitable conditions existed."
        }
    }
    
    func missionOverviewExpanded() -> String {
        switch self {
        case .curiosity:
            return "Curiosity set out to answer the question: Did Mars ever have the right environmental conditions to support small life forms called microbes? Early in its mission, Curiosity's scientific tools found chemical and mineral evidence of past habitable environments on Mars. It continues to explore the rock record from a time when Mars could have been home to microbial life.\n\nCuriosity carries the biggest, most advanced instruments for scientific studies ever sent to the Martian surface. The history of Martian climate and geology is written in the chemistry and structure of the rocks and soil. Curiosity reads this record by analyzing powdered samples drilled from rocks. It also measures the chemical fingerprints present in different rocks and soils to determine their composition and history, especially their past interactions with water."
        case .opportunity:
            return "In January 2004, two robotic geologists named Spirit and Opportunity landed on opposite sides of the red planet. With far greater mobility than the 1997 Mars Pathfinder rover, these robotic explorers have trekked for miles across the Martian surface, conducting field geology and making atmospheric observations. Carrying identical, sophisticated sets of science instruments, both rovers have found evidence of ancient Martian environments where intermittently wet and habitable conditions existed.\n\nWith data from the rovers, mission scientists have reconstructed an ancient past when Mars was awash in water. Spirit and Opportunity each found evidence for past wet conditions that possibly could have supported microbial life. Opportunity's study of 'Eagle' and 'Endurance' craters revealed evidence for past inter-dune playa lakes that evaporated to form sulfate-rich sands. The sands were reworked by water and wind, solidified into rock, and soaked by groundwater.\n\nBoth rovers exceeded their planned 90-day mission lifetimes by many years. Spirit lasted 20 times longer than its original design until its final communication to Earth on March 22, 2010. Opportunity continues to operate more than a decade after launch. In 2015, Opportunity broke the record for extraterrestrial travel by rolling greater than the distance of a 26-mile (42-kilometer) marathon."
        case .spirit:
            return "In January 2004, two robotic geologists named Spirit and Opportunity landed on opposite sides of the red planet. With far greater mobility than the 1997 Mars Pathfinder rover, these robotic explorers have trekked for miles across the Martian surface, conducting field geology and making atmospheric observations. Carrying identical, sophisticated sets of science instruments, both rovers have found evidence of ancient Martian environments where intermittently wet and habitable conditions existed.\n\nWith data from the rovers, mission scientists have reconstructed an ancient past when Mars was awash in water. Spirit and Opportunity each found evidence for past wet conditions that possibly could have supported microbial life. Opportunity's study of 'Eagle' and 'Endurance' craters revealed evidence for past inter-dune playa lakes that evaporated to form sulfate-rich sands. The sands were reworked by water and wind, solidified into rock, and soaked by groundwater.\n\nBoth rovers exceeded their planned 90-day mission lifetimes by many years. Spirit lasted 20 times longer than its original design until its final communication to Earth on March 22, 2010. Opportunity continues to operate more than a decade after launch. In 2015, Opportunity broke the record for extraterrestrial travel by rolling greater than the distance of a 26-mile (42-kilometer) marathon."
        }
    }
}
