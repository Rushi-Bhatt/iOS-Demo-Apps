//
//  ProfileTabHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/16/21.
//

import UIKit

protocol ProfileTabHeaderCollectionReusableViewDelegate: AnyObject {
    
    func profileTabHeaderDidTapGridTabButton(_ header: ProfileTabHeaderCollectionReusableView)
    func profileTabHeaderDidTapTaggedTabButton(_ header: ProfileTabHeaderCollectionReusableView)
    
}

final class ProfileTabHeaderCollectionReusableView: UICollectionReusableView {
 
    static let reuseIdentifier = "ProfileTabHeaderCollectionReusableView"
    
    weak var delegate: ProfileTabHeaderCollectionReusableViewDelegate?
    
    private let gridTabButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemBlue
        button.contentMode = .scaleAspectFill
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        button.clipsToBounds = true
        return button
    }()
    
    private let taggedTabButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemGray
        button.contentMode = .scaleAspectFill
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(gridTabButton)
        addSubview(taggedTabButton)
        gridTabButton.addTarget(self, action: #selector(didTapGridTabButton), for: .touchUpInside)
        taggedTabButton.addTarget(self, action: #selector(didTapTaggedTabButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let verticalPadding: CGFloat = 12.0
        let buttonSize = height - (2 * verticalPadding)
        let gridTabButtonX = (width/2 - buttonSize)/2
        gridTabButton.frame = CGRect(x: gridTabButtonX, y: verticalPadding, width: buttonSize, height: buttonSize)
        taggedTabButton.frame = CGRect(x: gridTabButtonX + width/2, y: verticalPadding, width: buttonSize, height: buttonSize)
    }
    
    @objc private func didTapGridTabButton() {
        gridTabButton.tintColor = .systemBlue
        taggedTabButton.tintColor = .systemGray
        delegate?.profileTabHeaderDidTapGridTabButton(self)
    }
    
    @objc private func didTapTaggedTabButton() {
        gridTabButton.tintColor = .systemGray
        taggedTabButton.tintColor = .systemBlue
        delegate?.profileTabHeaderDidTapTaggedTabButton(self)
    }
    
}
