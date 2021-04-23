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

extension UIImage {
    
    // Credit: https://stackoverflow.com/a/49335009
    // Resized an image based on the given width
    // Used to scale SVG images to fit on iPad
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UIControl {
    
    // Credit: https://www.roryba.in/programming/swift/2018/03/24/animating-uibutton.html
    // Add scale up/down animation when the user taps the button
    func setupAnimations() {
        addTarget(self, action: #selector(animateDown), for: [.touchUpInside, .touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
    }
    
    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 3,
            options: [.curveEaseInOut],
            animations: {
                button.transform = transform
            }
        )
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

extension UIDevice {
    
    var isIPhoneXOrBigger: Bool {
        // 812.0 on iPhone X, XS
        // 896.0 on iPhone XS Max, XR
        return UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.height >= 812
    }
    
    var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var appearance: String {
        return UITraitCollection.current.userInterfaceStyle == .dark ? "dark" : "light"
    }
    
    var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
}
