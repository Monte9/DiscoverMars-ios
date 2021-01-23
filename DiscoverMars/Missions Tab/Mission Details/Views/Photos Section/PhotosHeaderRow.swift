//
//  PhotosHeaderRow.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 1/23/21.
//

import Foundation
import UIKit

class PhotosHeaderRow: UIView {
    
    // MARK: Initialization
    
    var photos = [Photo]() {
        didSet {
            // Set the imageCount label text
            let photoWord = singularPluralWork(word: "Image", count: photos.count)
            imageCountLabel.text = "\(photos.count) \(photoWord)"
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addSubview(imageCountLabel)
        addSubview(sizeControlStackView)
        
        [largeLabel, dividerLine, smallLabel].forEach { sizeControlStackView.addArrangedSubview($0) }
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
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return stackView
    }()
    
    private lazy var largeLabel: UILabel = {
        let label = UILabel()
        label.text = "large"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "orange")
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "orange")
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        view.heightAnchor.constraint(equalToConstant: 32).isActive = true
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        return view
    }()
    
    private lazy var smallLabel: UILabel = {
        let label = UILabel()
        label.text = "small"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "orange")
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
}
