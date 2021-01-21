//
//  LandingSectionView.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/18/21.
//

import Foundation
import UIKit

class LandingSectionView: UIView {
    
    // MARK: Initialization
    
    private let mission: Mission
    
    init(mission: Mission) {
        self.mission = mission
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        sectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sectionView)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            sectionView.topAnchor.constraint(equalTo: topAnchor),
            sectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    // MARK: UI Views
    
    private lazy var dateRow = SectionRow(title: "Date", value: mission.landingDate)
    private lazy var locationRow = SectionRow(title: "Location", value: mission.landingSite)
    
    private lazy var sectionRows = [dateRow, locationRow]
    private lazy var sectionView = SectionView(title: "Landing", rows: sectionRows)
    
}
