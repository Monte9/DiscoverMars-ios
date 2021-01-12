//
//  Extensions.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/10/21.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func setStatusBar(backgroundColor: UIColor?) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
    
}

extension String {
    
    func titleCase() -> String {
        return self
            .replacingOccurrences(of: "([A-Z])",
                                  with: " $1",
                                  options: .regularExpression,
                                  range: range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized // If input is in llamaCase
    }
    
}

extension Int {
    
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value:self))!
    }
    
}
