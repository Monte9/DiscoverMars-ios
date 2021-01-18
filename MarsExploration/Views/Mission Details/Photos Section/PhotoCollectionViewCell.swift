//
//  PhotoCollectionViewCell.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/13/21.
//

import Foundation
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    public static let identifier = "PhotoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    func setupViews() {
        addSubview(imageView)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    // MARK: UI Views

    let imageView: ImageView = {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
}
