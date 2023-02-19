//
//  Answer.swift
//  Instacart
//
//  Created by Rushi Bhatt on 1/24/23.
//

import Foundation

struct Answer: Codable {
    let id: Int
    let imageURL: String
    let isCorrect: Bool
}

extension Answer {
    static func stubbed() -> [Answer] {
        return [
            .init(id: 1,
                   imageURL: "https://picsum.photos/id/237/200",
                   isCorrect: true),
            .init(id: 2,
                   imageURL: "https://picsum.photos/id/239/200",
                   isCorrect: false),
            .init(id: 3,
                   imageURL: "https://picsum.photos/id/239/200",
                   isCorrect: false),
            .init(id: 4,
                   imageURL: "https://picsum.photos/id/240/200",
                   isCorrect: false),
        
        ]
    }
}
