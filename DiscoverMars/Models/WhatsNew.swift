//
//  WhatsNew.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 4/23/21.
//

import Foundation

enum WhatsNewType {
    case summaryOnly
    case all
}

class WhatsNew {
    var type: WhatsNewType
    var number: String?
    var title: String?
    var summary: String
    
    init(type: WhatsNewType, number: String?, title: String?, summary: String) {
        self.type = type
        self.number = number
        self.title = title
        self.summary = summary
    }
}
