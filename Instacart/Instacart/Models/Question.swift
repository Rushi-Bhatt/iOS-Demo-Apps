//
//  Question.swift
//  Instacart
//
//  Created by Rushi Bhatt on 1/24/23.
//

import Foundation

struct Question: Codable {
    let question: String
    let answers: [Answer]
}

extension Question {
    static func stubbed() -> [Question] {
        return [
            .init(question: "Which one of these is carrot?",
                  answers: Answer.stubbed()),
            .init(question: "Which one of these is avacado?",
                  answers: Answer.stubbed())
        ]
    }
}
