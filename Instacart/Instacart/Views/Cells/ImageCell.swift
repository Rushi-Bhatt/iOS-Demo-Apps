//
//  ImageCell.swift
//  Instacart
//
//  Created by Rushi Bhatt on 1/24/23.
//

import Foundation
import UIKit
import SDWebImage

final class ImageCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ImageCell"
    
    private var viewModel: ImageCellViewModel?
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10.0
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateTap() {
        if viewModel?.isChosen == true {
            // select the cell
            UIView.animate(withDuration: 0.1,
                           animations: {
                self.contentView.backgroundColor = .systemGreen
                self.imageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: nil)
        } else {
            // deselect the cell
            UIView.animate(withDuration: 0.1,
                           animations: {
                self.contentView.backgroundColor = .systemBackground
                self.imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            },
            completion: nil)
        }
    }
    
    private func setupView() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configureCell(with image: String) {
        imageView.image = UIImage(named: image)
    }
    
    func configureflowCell(with viewModel: ImageCellViewModel) {
        self.viewModel = viewModel
        imageView.sd_setImage(with: viewModel.imageURL,
                              placeholderImage: UIImage(named: "Logo.png"),
                              completed: nil)
    }
}


