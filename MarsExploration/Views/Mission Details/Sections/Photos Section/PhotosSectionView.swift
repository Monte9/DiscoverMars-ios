//
//  PhotosSectionView.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/10/21.
//

import Foundation
import UIKit

class PhotosSectionView: UIView {
    
    private var photos = [Photo]()
    
    private var activityView: UIActivityIndicatorView!
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        activityView = UIActivityIndicatorView(style: .medium)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityView)
        
        // Setup Constraints
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            activityView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        activityView.startAnimating()
    }

    func hideActivityIndicator(){
        activityView.stopAnimating()
    }
    
    // MARK: Network Requests
    
    private func fetchPhotos() {
        showActivityIndicator()
        
        NetworkManager.shared.fetchPhotos(for: .curiosity, and: 2000) { result in
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
        print(photos.count)
        
        // Setup CollectionView
        addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor.clear

        // Setup Constraints
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 600),
        ])
    }
    
    // MARK: Error View
    
    private func displayErrorView() {
        addSubview(errorLabel)
        
        // Setup Constraints
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addSubview(headerLabel)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: UI Views
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "text")
        label.font = UIFont(name: "Inter-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Unable to Connect"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "text")
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
}

extension PhotosSectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected photo")
        let photo = photos[indexPath.section]
        print(photo.url)
    }
    
}

extension PhotosSectionView: UICollectionViewDataSource {
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

extension PhotosSectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (readableContentGuide.layoutFrame.width - 32) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 10)
    }
    
}
