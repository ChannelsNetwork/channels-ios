//
//  FeedViewController.swift
//  channels
//
//  Created by Preet Shihn on 9/11/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCollections

class FeedViewController : MDCCollectionViewController {
    let appBar = MDCAppBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styler.cellStyle = .card
        
        initializeAppBar()
        
        
        title = "Channels"
    }
    
    private func initializeAppBar() {
        addChildViewController(appBar.headerViewController)
        appBar.headerViewController.headerView.tintColor = UIColor.white
        appBar.headerViewController.headerView.backgroundColor = Theme.primary
        appBar.headerViewController.headerView.trackingScrollView = self.collectionView
        appBar.navigationBar.tintColor = UIColor.black
        appBar.addSubviewsToParent()
        
//        guard let image = UIImage(named: "bluebg") else {
//            return
//        }
//        let headerView = appBar.headerViewController.headerView
//        let imageView = UIImageView(image: image)
//        imageView.frame = headerView.bounds
//        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        headerView.insertSubview(imageView, at: 0)
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // Add some mock text to the cell.
        if let textCell = cell as? MDCCollectionViewTextCell {
            let animals = ["Lions", "Tigers", "Bears", "Monkeys"]
            textCell.textLabel?.text = animals[indexPath.item]
        }
        
        return cell
    }

}
