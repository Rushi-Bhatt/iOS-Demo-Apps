//
//  FeaturedAppController.swift
//  AppStore
//
//  Created by Rushi Bhatt on 11/14/20.
//  Copyright © 2020 Rushi Bhatt. All rights reserved.
//

import UIKit

class FeaturedAppController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var categoryCellId = "categoryCellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.backgroundColor = .white
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellId, for: indexPath) as! CategoryCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 220)
    }

}

