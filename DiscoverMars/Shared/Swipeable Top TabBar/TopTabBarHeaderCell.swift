//
//  TopTabBarHeaderCell.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/22/21.
//

// Credit: Suprianto Djamalu on 03/08/19.
// Source: https://github.com/erthru/SlidingTabsExample

import Foundation
import UIKit

class TopTabBarHeaderCell: UICollectionViewCell {
    
    private let label = UILabel()
    private let indicator = UIView()
    
    var text: String! {
        didSet {
            label.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func select(didSelect: Bool, activeColor: UIColor, inActiveColor: UIColor){
        indicator.backgroundColor = activeColor
        
        if didSelect {
            label.textColor = activeColor
            indicator.isHidden = false
        } else {
            label.textColor = inActiveColor
            indicator.isHidden = true
        }
    }
    
    private func setupUI(){
        // View
        self.addSubview(label)
        self.addSubview(indicator)
        
        // Label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        // Indicator
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        indicator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        indicator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
}
