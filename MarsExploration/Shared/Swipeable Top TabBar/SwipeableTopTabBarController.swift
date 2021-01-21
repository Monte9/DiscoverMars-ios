//
//  SwipeableTopTabBarController.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/22/21.
//

// Credit: Suprianto Djamalu on 03/08/19
// Source: https://github.com/erthru/SlidingTabsExample

import UIKit

class SwipeableTopTabBarController: UIViewController {
    
    private let collectionHeader = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let collectionPage = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
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
    
    private var items = [UIViewController]()
    private var titles = [String]()
    
    // MARK: View Lifecycle
  
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      collectionHeader.collectionViewLayout.invalidateLayout()
      collectionPage.collectionViewLayout.invalidateLayout()
      
      let pageOffset = CGPoint(
        // for landscape mode
        x: Int((self.view.bounds.width)) * currentPosition ,
        y: 0
      )
      
      self.collectionPage.setContentOffset(pageOffset, animated: false)
      self.collectionPage.reloadData()
    }
  
    func addItem(item: UIViewController, title: String){
        items.append(item)
        titles.append(title)
    }
    
    func build(){
        // view
        view.addSubview(collectionHeader)
        view.addSubview(collectionPage)
        
        // collectionHeader
        collectionHeader.translatesAutoresizingMaskIntoConstraints = false
        collectionHeader.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionHeader.heightAnchor.constraint(equalToConstant: heightHeader).isActive = true
        (collectionHeader.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionHeader.showsHorizontalScrollIndicator = false
        collectionHeader.backgroundColor = colorHeaderBackground
        collectionHeader.register(TopTabBarHeaderCell.self, forCellWithReuseIdentifier: Constants.collectionHeaderIdentifier)
        collectionHeader.delegate = self
        collectionHeader.dataSource = self
        collectionHeader.reloadData()
        
        // collectionPage
        collectionPage.translatesAutoresizingMaskIntoConstraints = false
        collectionPage.topAnchor.constraint(equalTo: collectionHeader.bottomAnchor).isActive = true
        collectionPage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionPage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionPage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionPage.backgroundColor = UIColor(named: "background")
        collectionPage.showsHorizontalScrollIndicator = false
        (collectionPage.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionPage.isPagingEnabled = true
        collectionPage.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.collectionPageIdentifier)
        collectionPage.delegate = self
        collectionPage.dataSource = self
        collectionPage.reloadData()
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
        
        return items.count
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionPageIdentifier, for: indexPath)
        let vc = items[indexPath.row]
        
        cell.addSubview(vc.view)
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.topAnchor.constraint(equalTo: cell.topAnchor, constant: 28).isActive = true
        vc.view.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SwipeableTopTabBarController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionHeader {
            if tabStyle == .fixed {
                let spacer = CGFloat(titles.count)
                return CGSize(width: view.frame.width / spacer, height: heightHeader)
            } else {
                return CGSize(width: view.frame.width * 20 / 100, height: heightHeader)
            }
        }
        
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionHeader {
            return 10
        }
        
        return 0
    }
}
