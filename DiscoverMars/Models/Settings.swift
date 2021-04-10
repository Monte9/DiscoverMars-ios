//
//  Settings.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 4/6/21.
//

import Foundation

enum SettingType {
    case whatsNew
    case monteContributor
    case spencerContributor
    case nasaAPI
    case shareApp
    case followTwitter
    case contactUs
}

class Setting {
    var type: SettingType
    var title: String
    var subtitle: String?
    var urlString: String?
    
    init(type: SettingType, title: String, subtitle: String? = nil, urlString: String? = nil) {
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.urlString = urlString
    }
}
