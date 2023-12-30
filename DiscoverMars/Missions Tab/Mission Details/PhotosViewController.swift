//
//  PhotosViewController.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/22/21.
//

import Foundation
import UIKit
import NYTPhotoViewer

protocol PhotosViewControllerDelegate: AnyObject {
    func didSelectPhotoCellView(from viewController: UIViewController, photoViewer: NYTPhotosViewController)
    func didDismissPhotoViewerModal(from viewController: UIViewController)
}

enum PhotoActionType: String {
    case fullscreen
    case dismissed
    case slideshow
    case share
}

class PhotosViewController: UIViewController {
    
    private var activityView: UIActivityIndicatorView!
    
    // Setup photos for the collectionView
    private var photos = [Photo]()
    private var photoSize: PhotoSize = .large {
        didSet {
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    // Setup Slideshow for the NYTPhotoViewer
    private var slideshow = [NYTPhotoBox]()
    private var photoViewer: NYTPhotosViewController?
    
    private var selectedPhotoCellView: UIView?
    
    // MARK: Initialization
    
    private let mission: Mission
    private let delegate: PhotosViewControllerDelegate?
    init(for mission: Mission, delegate: PhotosViewControllerDelegate? = nil) {
        self.mission = mission
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        
        // Set the background color for the view
        view.backgroundColor = UIColor.init(named: "background")

        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupViews()
        setupConstraints()
        
        fetchPhotos()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Activity Indicator
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityView)
        
        // Setup Constraints
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        activityView.startAnimating()
    }
    
    func hideActivityIndicator(){
        activityView.stopAnimating()
    }
    
    // MARK: Network Requests
    
    private func fetchPhotos() {
        showActivityIndicator()
        
        NetworkManager.shared.fetchPhotos(for: mission.rover, onSol: mission.maxSol) { result in
            self.hideActivityIndicator()
            
            switch result {
            case .success(let photos):
                self.photos = photos
                self.populateData()
                
                // Setup slideshow from the photos
                self.slideshow = photos.map { NYTPhotoBox($0) }
            case .failure(let error):
                print("Failed to fetch missions: \(error)")
                self.displayErrorView()
            }
        }
    }
    
    // MARK: Populate Data
    
    private func populateData() {
        // Set the photos on the HeaderRow
        photosHeaderRow.photos = photos
        
        // Setup CollectionView
        view.addSubview(collectionView)

        // Setup Constraints
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: photosHeaderRow.bottomAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4),
            collectionView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
        ])
    }
    
    // MARK: Error View
    
    private func displayErrorView() {
        view.addSubview(errorLabel)
        
        // Setup Constraints
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        view.addSubview(photosHeaderRow)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photosHeaderRow.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            photosHeaderRow.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            photosHeaderRow.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
        ])
    }
    
    // MARK: UI Views
    
    private lazy var photosHeaderRow: PhotosHeaderRow = {
        let row = PhotosHeaderRow(mission: mission, delegate: self)
        row.translatesAutoresizingMaskIntoConstraints = false
        return row
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Unable to Connect"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "orange")
        label.font = UIFont(name: "Inter-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
}

// MARK: - UICollectionViewDelegate

extension PhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Store the selectedPhoto cell so it can be referenced later on
        selectedPhotoCellView = self.collectionView.cellForItem(at: indexPath)
        
        // Initialize the photoViewer with current index of the selected photo
        photoViewer = NYTPhotosViewController(dataSource: self, initialPhotoIndex: indexPath.row, delegate: self)
        
        /// Track analytics event `mission_details_screen.photos`
        let properties = [
            "action": PhotoActionType.fullscreen.rawValue,
            "mission": mission.missionName,
            "rover": mission.roverName,
        ]
        MixpanelAnalytics.shared.track("mission_details_screen.photos", with: properties)
        
        // Setup the Slideshow with Image URLs
        for photoBox in slideshow {
            let imageView = ImageView()
            imageView.loadImage(urlString: photoBox.value.url)
            photoBox.image = imageView.image
            photoViewer?.update(photoBox)
        }
        
        if let photoViewer = photoViewer {
            delegate?.didSelectPhotoCellView(from: self, photoViewer: photoViewer)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.item]
        cell.imageView.loadImage(urlString: photo.url)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let smallImageWidth = (view.readableContentGuide.layoutFrame.width - 24) / 3
        let largeImageWidth = (view.readableContentGuide.layoutFrame.width)
        let size = photoSize == .small ? smallImageWidth : largeImageWidth
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return photoSize == .small ? 12 : 16
    }
}

// MARK: - PhotosHeaderRowDelegate

extension PhotosViewController: PhotosHeaderRowDelegate {
    
    func photosHeaderRowDidChange(_ view: PhotosHeaderRow, photoSize: PhotoSize) {
        self.photoSize = photoSize
    }
}

// MARK: - NYTPhotosViewControllerDelegate

extension PhotosViewController: NYTPhotosViewControllerDelegate {
    
    func photosViewController(_ photosViewController: NYTPhotosViewController, handleActionButtonTappedFor photo: NYTPhoto) -> Bool {
        /// Track analytics event `mission_details_screen.photos`
        let properties = [
            "action": PhotoActionType.share.rawValue,
            "mission": mission.missionName,
            "rover": mission.roverName,
        ]
        MixpanelAnalytics.shared.track("mission_details_screen.photos", with: properties)
        
        // Handled iPad custom ShareSheet
        guard UIDevice.current.userInterfaceIdiom == .pad, let photoImage = photo.image else {
            return false
        }
        
        let shareActivityViewController = UIActivityViewController(activityItems: [photoImage], applicationActivities:nil)
        shareActivityViewController.completionWithItemsHandler = {(activityType:UIActivity.ActivityType?, completed:Bool, items:[Any]?, error:Error?) in
            if completed {
                photosViewController.delegate?.photosViewController!(photosViewController, actionCompletedWithActivityType: activityType?.rawValue)
            }
        }
        
        shareActivityViewController.popoverPresentationController?.barButtonItem = photosViewController.rightBarButtonItem
        photosViewController.present(shareActivityViewController, animated: true, completion: nil)
        
        return true
    }
    
    func photosViewController(_ photosViewController: NYTPhotosViewController, referenceViewFor photo: NYTPhoto) -> UIView? {
        return selectedPhotoCellView
    }

    func photosViewControllerDidDismiss(_ photosViewController: NYTPhotosViewController) {
        photoViewer = nil
        
        /// Track analytics event `mission_details_screen.photos`
        let properties = [
            "action": PhotoActionType.dismissed.rawValue,
            "mission": mission.missionName,
            "rover": mission.roverName,
        ]
        MixpanelAnalytics.shared.track("mission_details_screen.photos", with: properties)
        
        delegate?.didDismissPhotoViewerModal(from: self)
    }
    
    func photosViewController(_ photosViewController: NYTPhotosViewController, didNavigateTo photo: NYTPhoto, at photoIndex: UInt) {
        let indexPath = IndexPath(row: Int(photoIndex), section: 0)
        
        /// Track analytics event `mission_details_screen.photos`
        let properties = [
            "action": PhotoActionType.slideshow.rawValue,
            "mission": mission.missionName,
            "rover": mission.roverName,
        ]
        MixpanelAnalytics.shared.track("mission_details_screen.photos", with: properties)
        
        // Store the selectedPhoto cell so it can be referenced later on
        selectedPhotoCellView = self.collectionView.cellForItem(at: indexPath)
    }
}

// MARK: - NYTPhotoViewerDataSource

extension PhotosViewController: NYTPhotoViewerDataSource {

    @objc var numberOfPhotos: NSNumber? {
        return NSNumber(integerLiteral: slideshow.count)
    }

    @objc func index(of photo: NYTPhoto) -> Int {
        guard let box = photo as? NYTPhotoBox else { return NSNotFound }
        return slideshow.firstIndex(where: { $0.value.identifier == box.value.identifier }) ?? NSNotFound
    }

    @objc func photo(at index: Int) -> NYTPhoto? {
        guard index < slideshow.count else { return nil }
        return slideshow[index]
    }
}
