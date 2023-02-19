//
//  ImageCellViewModel.swift
//  Instacart
//
//  Created by Rushi Bhatt on 1/24/23.
//

import Foundation

final class ImageCellViewModel {
    
    var isChosen: Bool = false
    var isCorrect: Bool = false
    var imageURL: URL?
    
    init(with model: Answer) {
        self.isCorrect = model.isCorrect
        self.imageURL = URL(string: model.imageURL)
    }
}
