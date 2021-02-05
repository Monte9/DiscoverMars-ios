//
//  PhotoViewerCoordinator.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 2/5/21.
//

// Credit: https://github.com/nytimes/NYTPhotoViewer

import NYTPhotoViewer

/// Coordinates interaction between the application's data layer and the photo viewer component.
final class PhotoViewerCoordinator: NSObject, NYTPhotoViewerDataSource {
    let slideshow: [NYTPhotoBox]
    
    lazy var photoViewer: NYTPhotosViewController = {
        return NYTPhotosViewController(dataSource: self)
    }()
    
    init(photos: [Photo]) {
        self.slideshow = photos.map { NYTPhotoBox($0) }
        super.init()
        self.fetchPhotos()
    }
    
    func fetchPhotos() {
        for photoBox in slideshow {
            let imageView = ImageView()
            imageView.loadImage(urlString: photoBox.value.url)
            photoBox.image = imageView.image
            photoViewer.update(photoBox)
        }
    }
    
    // MARK: NYTPhotoViewerDataSource
    
    @objc
    var numberOfPhotos: NSNumber? {
        return NSNumber(integerLiteral: slideshow.count)
    }
    
    @objc
    func index(of photo: NYTPhoto) -> Int {
        guard let box = photo as? NYTPhotoBox else { return NSNotFound }
        return slideshow.firstIndex(where: { $0.value.identifier == box.value.identifier }) ?? NSNotFound
    }
    
    @objc
    func photo(at index: Int) -> NYTPhoto? {
        guard index < slideshow.count else { return nil }
        return slideshow[index]
    }
}
