//
//  HomeFeedPostTableViewCell.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/15/21.
//

import UIKit

final class HomeFeedPostTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "HomeFeedPostTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
