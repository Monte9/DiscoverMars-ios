//
//  SwipeableTopTabBarController.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/22/21.
//

// Credit: Suprianto Djamalu on 03/08/19
// Source: https://github.com/erthru/SlidingTabsExample

import Foundation
import UIKit

class SwipeableTopTabBarController: UIViewController {
    
    // MARK: Constants
        
    private enum SlidingTabStyle: String {
        case fixed
        case flexible
    }

    private enum Constants {
        static let collectionHeaderIdentifier = "COLLECTION_HEADER_IDENTIFIER"
        static let collectionPageIdentifier = "COLLECTION_PAGE_IDENTIFIER"
    }
    
    // MARK: Private Variables
    
    // Set colors for the tab
    private let colorHeaderActive: UIColor = UIColor(named: "orange") ?? .white
    private let colorHeaderInActive: UIColor = UIColor(named: "orange") ?? .white
    private let colorHeaderBackground: UIColor = UIColor(named: "background") ?? .white

    // Set the tab style
    private let tabStyle = SlidingTabStyle.fixed

    // Set current selected position & height for the tabs
    private var currentPosition = 0
    private let heightHeader: CGFloat = 57
    
    // ViewControllers to be displayed in tabs
    private var tabs = [UIViewController]()
    private var titles = [String]()
    
    // MARK: View Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set CollectionHeader delegate and dataSource
        collectionHeader.delegate = self
        collectionHeader.dataSource = self

        // Set CollectionPage delegate and dataSource
        collectionPage.delegate = self
        collectionPage.dataSource = self
    }
  
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionHeader.collectionViewLayout.invalidateLayout()
        collectionPage.collectionViewLayout.invalidateLayout()
      
        // for landscape mode
        let pageOffset = CGPoint(x: Int((self.view.bounds.width)) * currentPosition, y: 0)
      
        self.collectionPage.setContentOffset(pageOffset, animated: false)
        self.collectionPage.reloadData()
    }
    
    // MARK: Add Items
  
    func addTab(viewController: UIViewController, title: String){
        tabs.append(viewController)
        titles.append(title)
    }
    
    // MARK: Setup Views & Constraints
    
    func setup(){
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(collectionHeader)
        view.addSubview(collectionPage)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionHeader.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            collectionHeader.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            collectionHeader.heightAnchor.constraint(equalToConstant: heightHeader),
            collectionPage.topAnchor.constraint(equalTo: collectionHeader.bottomAnchor),
            collectionPage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionPage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionPage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    // MARK: Helpers
    
    func setCurrentPosition(position: Int) {
        currentPosition = position
        let path = IndexPath(item: currentPosition, section: 0)
        
        DispatchQueue.main.async {
            if self.tabStyle == .flexible {
                guard let rectHeader = self.collectionHeader.layoutAttributesForItem(at: path)?.frame else { return }
                self.collectionHeader.scrollRectToVisible(rectHeader, animated: false)
            }
            self.collectionHeader.reloadData()
        }
        
        DispatchQueue.main.async {
            guard let rect = self.collectionPage.layoutAttributesForItem(at: path)?.frame else { return }
            self.collectionPage.scrollRectToVisible(rect, animated: false)
        }
        self.collectionPage.reloadData()
    }
    
    // MARK: UI Views
     
     private lazy var collectionHeader: UICollectionView = {
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
         (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
         collectionView.showsHorizontalScrollIndicator = false
         collectionView.backgroundColor = colorHeaderBackground
         collectionView.register(TopTabBarHeaderCell.self, forCellWithReuseIdentifier: Constants.collectionHeaderIdentifier)
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         return collectionView
     }()
 
     private lazy var collectionPage: UICollectionView = {
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
         collectionView.showsHorizontalScrollIndicator = false
         collectionView.backgroundColor = UIColor(named: "background")
         (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
         collectionView.isPagingEnabled = true
         collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.collectionPageIdentifier)
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         return collectionView
     }()
}

// MARK: - UICollectionViewDelegate

extension SwipeableTopTabBarController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setCurrentPosition(position: indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionPage {
            let currentIndex = Int(self.collectionPage.contentOffset.x / collectionPage.frame.size.width)
            setCurrentPosition(position: currentIndex)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension SwipeableTopTabBarController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionHeader {
            return titles.count
        }
        
        return tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionHeader {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionHeaderIdentifier, for: indexPath) as! TopTabBarHeaderCell
            cell.text = titles[indexPath.row]
            
            var didSelect = false
            
            if currentPosition == indexPath.row {
                didSelect = true
            }
            
            cell.select(didSelect: didSelect, activeColor: colorHeaderActive, inActiveColor: colorHeaderInActive)
            
            return cell
        }
        
        let tabViewController = tabs[indexPath.row]
        tabViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionPageIdentifier, for: indexPath)
        cell.addSubview(tabViewController.view)
        
        NSLayoutConstraint.activate([
            tabViewController.view.topAnchor.constraint(equalTo: cell.topAnchor),
            tabViewController.view.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            tabViewController.view.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            tabViewController.view.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
        ])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SwipeableTopTabBarController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionHeader {
            if tabStyle == .fixed {
                let spacer = CGFloat(titles.count)
                return CGSize(width: view.readableContentGuide.layoutFrame.width / spacer, height: heightHeader)
            } else {
                return CGSize(width: view.frame.width * 20 / 100, height: heightHeader)
            }
        }
        
        return CGSize(width: collectionPage.bounds.size.width, height: collectionPage.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionHeader {
            return 10
        }
        
        return 0
    }
}
