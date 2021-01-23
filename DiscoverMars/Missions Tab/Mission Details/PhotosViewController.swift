//
//  PhotosViewController.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/22/21.
//

import Foundation
import UIKit

class PhotosViewController: UIViewController {
    
    private var activityView: UIActivityIndicatorView!
    private var photos = [Photo]()
    private var photoSize: PhotoSize = .small {
        didSet {
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    // MARK: Initialization
    
    private let mission: Mission
    init(for mission: Mission) {
        self.mission = mission
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the background color for the view
        view.backgroundColor = UIColor.init(named: "background")

        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupViews()
        setupConstraints()
        
        fetchPhotos()
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
        let row = PhotosHeaderRow(delegate: self)
        row.photoSize = photoSize
        row.translatesAutoresizingMaskIntoConstraints = false
        return row
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Unable to Connect"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "orange")
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
}

// MARK: - UICollectionViewDelegate

extension PhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: Open image in fullscreen mode
        let _ = photos[indexPath.section]
        
        if photoSize == .large {
            photosHeaderRow.photoSize = .small
            photoSize = .small
        } else {
            photosHeaderRow.photoSize = .large
            photoSize = .large
        }
        
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
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

extension PhotosViewController: PhotosHeaderRowDelegate {
    
    func photosHeaderRowDidChange(_ view: PhotosHeaderRow, photoSize: PhotoSize) {
        self.photoSize = photoSize
    }
}
