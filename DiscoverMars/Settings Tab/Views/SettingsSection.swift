//
//  SettingsSection.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 4/6/21.
//

import Foundation
import UIKit

protocol SettingsSectionDelegate {
    func didTapSection(with settingsRow: SettingsRow)
}

class SettingsSection: UIStackView {
    
    // MARK: Initialization
    
    let settings: [Setting]
    let delegate: SettingsSectionDelegate?
    
    init(settings: [Setting], delegate: SettingsSectionDelegate? = nil) {
        self.settings = settings
        self.delegate = delegate
        super.init(frame: .zero)
        
        axis = .vertical
        spacing = 12
        isUserInteractionEnabled = true
        
        setupViews()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addArrangedSubview(titleLabel)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        settings.forEach { setting in
            let settingsRow = SettingsRow(with: setting)
            settingsRow.titleLabel.text = setting.title
            if let subtitle = setting.subtitle, !subtitle.isEmpty {
                settingsRow.shouldDisplaySubtitle = true
                settingsRow.subtitleLabel.text = setting.subtitle
            } else {
                settingsRow.shouldDisplaySubtitle = false
            }
            
            settingsRow.addTarget(self, action: #selector(settingsRowTapped), for: .touchUpInside)
            
            addArrangedSubview(settingsRow)
        }
    }
    
    // MARK: Actions
    
    @objc private func settingsRowTapped(_ settingRow: SettingsRow) {
        delegate?.didTapSection(with: settingRow)
    }
    
    // MARK: UI Views
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "background")
        label.font = UIFont(name: "Inter-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
