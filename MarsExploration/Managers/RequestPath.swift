//
//  RequestPath.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/8/21.
//

import Foundation

// You can start using this key to make web service requests. Simply pass your key in the URL when making a web request.
// Here's an example: https://api.nasa.gov/planetary/apod?api_key=maiBleq3ql7plddEDkigXNisbFgXdMBpdCjLgGIO

class RequestPath: NSObject {
    static let baseURL = "https://api.nasa.gov/mars-photos/api/v1/"
    static let manifestURL = "manifests/"
    static let apiKey = "api_key=maiBleq3ql7plddEDkigXNisbFgXdMBpdCjLgGIO"
}
