//
//  MarsFactCard.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 2/7/21.
//

import Foundation
import UIKit

class MarsFactCard: UIControl {
    
    var descriptionText: String = "" {
        didSet {
            setupDescriptionLabel()
        }
    }
    
    // MARK: Initialization
    
    let fact: MarsFact
    
    init(for marsFact: MarsFact) {
        self.fact = marsFact
        super.init(frame: .zero)
        
        // Add drop shadow effect to the background
        backgroundColor = UIColor.clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5
        
        // Adds border radius
        layer.borderWidth = 0.4
        layer.borderColor = UIColor(named: "background")?.cgColor
        
        // Adds corder radius
        layer.cornerRadius = 20
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderColor = UIColor(named: "background")?.cgColor
        
        // Update the width of the factImage to work on iPad
        let padding: CGFloat = UIDevice.current.isIpad ? 128 : 24
        factImage.image = factImage.image?.resized(toWidth: readableContentGuide.layoutFrame.width - padding)
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(cardCountView)
        containerView.addSubview(factImage)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: cardCountView.leadingAnchor, constant: -16),
            cardCountView.topAnchor.constraint(equalTo: containerView.topAnchor),
            cardCountView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: cardCountView.leadingAnchor, constant: -16),
        ])
    }
    
    private func setupDescriptionLabel() {
        if descriptionText.isEmpty {
            setupViewsWithoutDescriptionLabel()
            return
        }
        
        // Add the description text
        descriptionLabel.text = descriptionText
        
        // Add the label to the view
        containerView.addSubview(descriptionLabel)
        
        // Setup contraints for the label
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            factImage.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            factImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            factImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    
    private func setupViewsWithoutDescriptionLabel() {
        NSLayoutConstraint.activate([
            factImage.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            factImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            factImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    
    // MARK: UI Views
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.frame = bounds
        view.backgroundColor = UIColor(named: "color.10")
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "background")
        label.font = UIFont(name: "Inter-Bold", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "background")
        label.layer.opacity = 0.6
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cardCountView: CardCountView = {
        let view = CardCountView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "background")
        label.font = UIFont(name: "Inter-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let factImage: ImageView = {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}
