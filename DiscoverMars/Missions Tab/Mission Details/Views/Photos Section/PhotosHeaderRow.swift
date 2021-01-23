//
//  PhotosHeaderRow.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 1/23/21.
//

import Foundation
import UIKit

enum PhotoSize {
    case large
    case small
}

class PhotosHeaderRow: UIView {
    
    var photos = [Photo]() {
        didSet {
            // Set the imageCount label text
            let photoWord = singularPluralWork(word: "Image", count: photos.count)
            imageCountLabel.text = "\(photos.count) \(photoWord)"
        }
    }
    
    // MARK: Initialization
    
    private var photoSize: PhotoSize {
        didSet {
            setCurrentPhotoSize()
        }
    }
    
    init(photoSize: PhotoSize) {
        self.photoSize = photoSize
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
        
        setCurrentPhotoSize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addSubview(imageCountLabel)
        addSubview(sizeControlStackView)
        
        [largeImagesButton, dividerLine, smallImagesButton].forEach { sizeControlStackView.addArrangedSubview($0) }
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            sizeControlStackView.topAnchor.constraint(equalTo: topAnchor),
            sizeControlStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sizeControlStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    // MARK: Actions
    
    private func setCurrentPhotoSize() {
        switch photoSize {
        case .large:
            largeImagesButton.setImage(UIImage(named: "large.image.size.selected"), for: .normal)
            smallImagesButton.setImage(UIImage(named: "small.image.size"), for: .normal)
        case .small:
            smallImagesButton.setImage(UIImage(named: "small.image.size.selected"), for: .normal)
            largeImagesButton.setImage(UIImage(named: "large.image.size"), for: .normal)
        }
    }
    
    @objc private func largeImageButtonTapped(_ sender: UIButton) {
        photoSize = .large
    }
    
    @objc private func smallImageButtonTapped(_ sender: UIButton) {
        photoSize = .small
    }
    
    // MARK: Helpers
    
    private func singularPluralWork(word: String, count: Int) -> String {
        if count > 1 {
            return "\(word)s"
        }
        
        return word
    }
    
    // MARK: UI Views
    
    private lazy var imageCountLabel: UILabel = {
        let label = UILabel()
        label.text = "- Images"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "orange")
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sizeControlStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return stackView
    }()
    
    private let largeImagesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "large.image.size"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.addTarget(self, action: #selector(largeImageButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "orange")
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        view.heightAnchor.constraint(equalToConstant: 32).isActive = true
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        return view
    }()
    
    private let smallImagesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "small.image.size"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.addTarget(self, action: #selector(smallImageButtonTapped), for: .touchUpInside)
        return button
    }()
}
