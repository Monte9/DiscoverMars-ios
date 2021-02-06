//
//  NYTPhotoBox.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 2/5/21.
//

import UIKit
import NYTPhotoViewer

/// A data model that implements the `NYTPhoto` protocol for use with NYTPhotoViewer
final class NYTPhotoBox: NSObject, NYTPhoto {
    
    // Stores the Photo object retured by the API
    let value: Photo
    
    init(_ photo: Photo) {
        value = photo
    }
    
    // MARK: NYTPhoto
    
    var image: UIImage?
    
    var imageData: Data?
    
    var placeholderImage: UIImage?
    
    var attributedCaptionTitle: NSAttributedString?
    
    var attributedCaptionSummary: NSAttributedString? {
        let attributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                          NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        return NSAttributedString(string: value.summary, attributes: attributes)
    }
    
    var attributedCaptionCredit: NSAttributedString? {
        let attributes = [NSAttributedString.Key.foregroundColor:UIColor.gray,
                          NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .footnote)]
        return NSAttributedString(string: value.credit, attributes: attributes)
    }
}

// MARK: NSObject Equality

extension NYTPhotoBox {
    
    @objc override func isEqual(_ object: Any?) -> Bool {
        guard let otherPhoto = object as? NYTPhotoBox else { return false }
        return value.identifier == otherPhoto.value.identifier
    }
}
