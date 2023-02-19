//
//  CategoryCell.swift
//  AppStore
//
//  Created by Rushi Bhatt on 11/14/20.
//  Copyright © 2020 Rushi Bhatt. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    private let appCellId = "appCellId"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let nl = UILabel()
        nl.text = "Best New Apps"
        nl.font = UIFont.systemFont(ofSize: 16)
        nl.translatesAutoresizingMaskIntoConstraints = false
        return nl
    }()
    
    let appCpllectionView: UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let dividerLine: UIView = {
        let dv = UIView()
        dv.backgroundColor = UIColor(white: 0.6, alpha: 0.4)
        dv.translatesAutoresizingMaskIntoConstraints = false
        return dv
    }()
    
    private func setupView() {
        addSubview(nameLabel)
        addSubview(appCpllectionView)
        addSubview(dividerLine)
        NSLayoutConstraint.activate([
            
            NSLayoutConstraint.init(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 15),
            NSLayoutConstraint.init(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -15),
            NSLayoutConstraint.init(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 20),
            
            
            NSLayoutConstraint.init(item: appCpllectionView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: appCpllectionView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: appCpllectionView, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: appCpllectionView, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1, constant: 35),
            
            
            NSLayoutConstraint.init(item: dividerLine, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 15),
            NSLayoutConstraint.init(item: dividerLine, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -15),
            NSLayoutConstraint.init(item: dividerLine, attribute: .top, relatedBy: .equal, toItem: appCpllectionView, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint.init(item: dividerLine, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: dividerLine, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 2)
        ])
        appCpllectionView.dataSource = self
        appCpllectionView.delegate = self
        appCpllectionView.register(AppCell.self, forCellWithReuseIdentifier: appCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: appCellId, for: indexPath) as! AppCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
}
