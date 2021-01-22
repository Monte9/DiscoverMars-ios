//
//  MissionSectionView.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/18/21.
//

import Foundation
import UIKit

class MissionSectionView: UIView {
    
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
    
    private lazy var missionRow = SectionRow(title: "Status", value: mission.status)
    private lazy var nameRow = SectionRow(title: "Name", value: mission.missionName)
    private lazy var typeRow = SectionRow(title: "Type", value: "Rover: \"\(mission.roverName)\"")
    private lazy var lastContactRow = SectionRow(title: "Last Contact", value: mission.maxDate)
    private lazy var vehicleRow = SectionRow(title: "Vehicle", value: mission.launchVehicle)
    
    private lazy var sectionRows = [missionRow, nameRow, typeRow, lastContactRow, vehicleRow]
    private lazy var sectionView = SectionView(title: "Mission", rows: sectionRows)
    
}
