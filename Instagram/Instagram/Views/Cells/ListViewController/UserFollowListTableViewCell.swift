//
//  UserFollowListTableViewCell.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/17/21.
//

import UIKit

protocol UserFollowListTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(_ model: UserRelationship)
}

final class UserFollowListTableViewCell: UITableViewCell {

    static let reuseIdentifier = "UserFollowListTableViewCell"
     
    weak var delegate: UserFollowListTableViewCellDelegate?
    
    private var model: UserRelationship?
    
    private let listImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(listImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageViewSize = contentView.height - 10.0
        listImageView.layer.cornerRadius = imageViewSize / 2.0
        listImageView.frame = CGRect(x: 5.0, y: 5.0, width: imageViewSize, height: imageViewSize)
        
        let followButtonWidth: CGFloat = contentView.width / 3.0
        let followButtonHeight: CGFloat = (contentView.height - 30)
        followButton.frame = CGRect(x: contentView.width - followButtonWidth - 5.0, y: 15, width: followButtonWidth, height: followButtonHeight)
        
        let labelHeight = (contentView.height - 10.0)/2
        nameLabel.frame = CGRect(x: listImageView.right + 5.0, y: 5.0, width: contentView.width - followButtonWidth - 15.0, height: labelHeight)
        usernameLabel.frame = CGRect(x: listImageView.right + 5.0, y: 5.0 + nameLabel.height, width: contentView.width - followButtonWidth - 15.0, height: labelHeight)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        listImageView.image = nil
        nameLabel.text = ""
        usernameLabel.text = ""
        followButton.setTitle("", for: .normal)
        followButton.backgroundColor = .systemBackground
    }
    
    public func configure(with model: UserRelationship) {
        self.model = model
        nameLabel.text = model.name
        usernameLabel.text = model.username
        switch model.type {
        case .following:
            // Set the button to non_following
            followButton.setTitle("Unfollow", for: .normal)
            followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
            followButton.layer.borderWidth = 1.0
            followButton.backgroundColor = .secondarySystemBackground
            followButton.setTitleColor(.label, for: .normal)
            break
        case .not_following:
            // Set the button to follow
            followButton.setTitle("Follow", for: .normal)
            followButton.backgroundColor = .systemBlue
            followButton.setTitleColor(.white, for: .normal)
            break
        }
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model  else { return }
        delegate?.didTapFollowUnfollowButton(model)
    }
}
