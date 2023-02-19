//
//  AppCell.swift
//  AppStore
//
//  Created by Rushi Bhatt on 11/14/20.
//  Copyright © 2020 Rushi Bhatt. All rights reserved.
//

import UIKit
class AppCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var imageView: UIImageView =  {
        let iv = UIImageView()
        iv.image = UIImage(named: "pp.png")
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let nameLabel: UILabel = {
        let nl = UILabel()
        nl.text = "PayPal: Better Money"
        nl.font = UIFont.systemFont(ofSize: 14)
        nl.lineBreakMode = .byWordWrapping
        nl.numberOfLines = 2
        return nl
    }()
    
    let categoryLabel: UILabel = {
        let nl = UILabel()
        nl.text = "Finance"
        nl.font = UIFont.systemFont(ofSize: 13)
        nl.textColor = .darkGray
        return nl
    }()
    
    let priceLabel: UILabel = {
        let nl = UILabel()
        nl.text = "$3.99"
        nl.font = UIFont.systemFont(ofSize: 13)
        nl.textColor = .darkGray
        return nl
    }()
    
    private func setupView() {
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(priceLabel)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        nameLabel.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 40)
        categoryLabel.frame = CGRect(x: 0, y: frame.width + 38, width: frame.width, height: 20)
        priceLabel.frame = CGRect(x: 0, y: frame.width + 56, width: frame.width, height: 20)
    }
}
