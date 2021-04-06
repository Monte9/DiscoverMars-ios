//
//  Settings.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 4/6/21.
//

import Foundation

class Setting {
    var title: String
    var subtitle: String?
    var url: String
    
    init(title: String, subtitle: String? = nil, url: String) {
        self.title = title
        self.subtitle = subtitle
        self.url = url
    }
}
