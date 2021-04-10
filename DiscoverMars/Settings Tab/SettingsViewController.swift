//
//  SettingsViewController.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 4/5/21.
//

import Foundation
import UIKit
import MessageUI

class SettingsViewController: UIViewController {
    
    private let settingsSections: KeyValuePairs = [
        "Updates": [
            Setting(type: .whatsNew, title: "See what’s new")
        ],
        "Contributors": [
            Setting(type: .monteContributor, title: "Monte Thakkar", subtitle: "Development", urlString: "https://twitter.com/MThakkar_"),
            Setting(type: .spencerContributor, title: "Spencer Everett", subtitle: "Design", urlString: "https://twitter.com/SP3V"),
            Setting(type: .nasaAPI, title: "NASA", subtitle: "API", urlString: "https://github.com/chrisccerami/mars-photo-api")
        ],
        "Engagement": [
            Setting(type: .shareApp, title: "Share Discover Mars"),
            Setting(type: .followTwitter, title: "Follow us on Twitter", urlString: "https://twitter.com/discovermarsapp"),
            Setting(type: .contactUs, title: "Contact us")
        ],
    ]
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "orange")
        
        setupViews()
        setupConstraints()
        
        setupSettingsSections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Remove the title from the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        // Show the Navigation Bar for all Child VCs
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        let isDarkMode = UITraitCollection.current.userInterfaceStyle == .dark
        return isDarkMode ? .darkContent : .lightContent
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(spacerViewTop)
        scrollView.addSubview(stackView)
        scrollView.addSubview(spacerViewBottom)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spacerViewTop.topAnchor.constraint(equalTo: scrollView.topAnchor),
            spacerViewTop.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            spacerViewTop.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            spacerViewTop.heightAnchor.constraint(equalToConstant: 24),
            stackView.topAnchor.constraint(equalTo: spacerViewTop.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            spacerViewBottom.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            spacerViewBottom.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            spacerViewBottom.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            spacerViewBottom.heightAnchor.constraint(equalToConstant: 24),
            spacerViewBottom.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    private func setupSettingsSections() {
        settingsSections.forEach { (sectionTitle, settings) in
            let section = SettingsSection(settings: settings, delegate: self)
            section.titleLabel.text = sectionTitle
            stackView.addArrangedSubview(section)
        }
    }
    
    // MARK: Actions
    
    private func presentShareSheet() {
        let items: [Any] = ["This app lets you see images from Mars!", URL(string: "https://www.discovermars.app")!]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityViewController, animated: true)
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["discovermarsapp@gmail.com"])
            mail.setMessageBody("<p>Reching out about the Discover Mars app.</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            print("Unable to open Mail app for Contact us")
        }
    }
    
    // MARK: UI Views
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let spacerViewTop: UIView = {
        let spacerView = UIView()
        spacerView.backgroundColor = .red
        spacerView.translatesAutoresizingMaskIntoConstraints =  false
        return spacerView
    }()
    
    private let spacerViewBottom: UIView = {
        let spacerView = UIView()
        spacerView.backgroundColor = .red
        spacerView.translatesAutoresizingMaskIntoConstraints =  false
        return spacerView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 35
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
}

// MARK: - SettingsSectionDelegate

extension SettingsViewController: SettingsSectionDelegate {
    
    func didTapSection(with settingsRow: SettingsRow) {
        if let urlString = settingsRow.setting.urlString,
           let url = URL(string: urlString),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        } else if settingsRow.setting.type == .whatsNew {
            let navController = UINavigationController(rootViewController: WhatsNewViewController())
            present(navController, animated: true, completion: nil)
        } else if settingsRow.setting.type == .shareApp {
            presentShareSheet()
        } else if settingsRow.setting.type == .contactUs {
            sendEmail()
        } else {
            print("missing Setting url or invalid type")
        }
    }
}

// MARK: - MFMailComposeViewControllerDelegate

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
