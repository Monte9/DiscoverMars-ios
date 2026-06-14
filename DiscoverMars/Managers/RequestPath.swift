//
//  RequestPath.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/8/21.
//

import Foundation

class RequestPath: NSObject {
    static let baseURL = "https://api.nasa.gov/mars-photos/api/v1/"
    static let manifestURL = "manifests/"
    static let roversURL = "rovers/"
    static let photosURL = "/photos"
    // The NASA API key is injected at build time from `Secrets.xcconfig` (see README).
    static let apiKey = "api_key=" + AppSecrets.nasaAPIKey
}

/// Secret values injected at build time via `Secrets.xcconfig` -> `Info.plist`.
///
/// Copy `Secrets.example.xcconfig` to `Secrets.xcconfig` (which is git-ignored) and
/// fill in your own keys. See the "Configuration" section of the README for details.
enum AppSecrets {
    /// NASA API key — get a free one at https://api.nasa.gov
    static let nasaAPIKey = infoPlistValue(for: "NASAAPIKey")

    /// Mixpanel project token — Mixpanel dashboard -> Settings -> Project Settings.
    static let mixpanelToken = infoPlistValue(for: "MixpanelToken")

    private static func infoPlistValue(for key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String,
              !value.isEmpty,
              !value.hasPrefix("YOUR_") else {
            #if DEBUG
            assertionFailure("""
                Missing value for Info.plist key "\(key)".
                Copy Secrets.example.xcconfig to Secrets.xcconfig and add your keys.
                See the README "Configuration" section.
                """)
            #endif
            return ""
        }
        return value
    }
}
