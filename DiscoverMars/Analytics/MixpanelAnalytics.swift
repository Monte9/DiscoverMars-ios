//
//  MixpanelAnalytics.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 3/3/21.
//

import Foundation
import Mixpanel

class MixpanelAnalytics {
    
    static let shared = MixpanelAnalytics()
    
    init() {
        // Setup Mixpanel Analytics tracking
        Mixpanel.initialize(token: "ff89f373a77211f077fc33e080313d16")
    }
    
    /// Track Mixpanel event with `String` key and `[String: String]` propeties
    func track(_ event: String, with properties: [String: String]? = nil) {
        let containsPropeties: String = properties != nil ? " with properties" : ""
        print("Tracking Mixpanel analytics event\(containsPropeties): \(event)")
        
        Mixpanel.mainInstance().track(
            event: event,
            properties: properties
        )
    }
}
