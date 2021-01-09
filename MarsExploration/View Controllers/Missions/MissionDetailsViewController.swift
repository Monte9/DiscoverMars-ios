//
//  MissionDetailsViewController.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/9/21.
//

import Foundation
import UIKit

class MissionDetailsViewController: UIViewController {
    
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
        view.backgroundColor = UIColor.init(named: "background")
        title = mission.missionName
    }
    
}
