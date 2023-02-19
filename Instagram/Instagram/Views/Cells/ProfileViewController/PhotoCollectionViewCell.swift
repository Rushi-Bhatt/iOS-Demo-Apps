//
//  PhotoCollectionViewCell.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/16/21.
//

import UIKit
import SDWebImage

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PhotoCollectionViewCell"

    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configureCell(with image: String) {
        imageView.image = UIImage(named: image)
    }
    
    func configureCell(with model: UserPost) {
        imageView.sd_setImage(with: model.thumbnailImage, completed: nil)
    }
}
