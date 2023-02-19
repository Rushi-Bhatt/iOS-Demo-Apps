//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/16/21.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
    
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
        
    static let reuseIdentifier = "ProfileInfoHeaderCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews()
        addActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
       return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.label, for: .normal)
       return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
       return button
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
       return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Rushi"
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "My name is Rushi!!"
        return label
    }()
    
    private func addSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(postsButton)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    private func addActions() {
        postsButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    @objc private func didTapPostsButton() {
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    
    @objc private func didTapFollowersButton() {
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    
    @objc private func didTapFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    
    @objc private func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(x: 5, y: 5, width: profilePhotoSize, height: profilePhotoSize).integral
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2
        
        let buttonSize = (width - 10 - profilePhotoSize)/3
        postsButton.frame = CGRect(x: profilePhotoImageView.right, y: 5, width: buttonSize, height: profilePhotoSize/2)
        followersButton.frame = CGRect(x: postsButton.right, y: 5, width: buttonSize, height: profilePhotoSize/2)
        followingButton.frame = CGRect(x: followersButton.right, y: 5, width: buttonSize, height: profilePhotoSize/2)
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right, y: postsButton.bottom, width: width - profilePhotoSize, height: profilePhotoSize/2)
        
        let bioSize = bioLabel.sizeThatFits(frame.size)
        nameLabel.frame = CGRect(x: 5, y: profilePhotoImageView.bottom, width: width - 10, height: 50)
        bioLabel.frame = CGRect(x: 5, y: nameLabel.bottom, width: width - 10, height: bioSize.height)
    }
    
}
