//
//  ImageView.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/8/21.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class ImageView: UIImageView {
    
    var imageUrlSting: String?
    
    func loadImage(urlString: String, completionHandler: ((Result<Void, Error>) -> Void)? = nil) {
        let url = URL(string: urlString)!
        
        image = nil
        imageUrlSting = urlString
        
        // return image from cache
        if let imageFromCache = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = imageFromCache
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                completionHandler?(.failure(error))
                return
            }
            
            guard (response as? HTTPURLResponse) != nil else {
                completionHandler?(.failure(NetworkManagerError.noResponse))
                return
            }
            
            guard let data = data else {
                completionHandler?(.failure(NetworkManagerError.missingData))
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data)
                
                if self.imageUrlSting == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: NSString(string: urlString))
            }
        }
        
        task.resume()
    }
}
