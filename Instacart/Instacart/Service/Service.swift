//
//  Service.swift
//  Instacart
//
//  Created by Rushi Bhatt on 1/24/23.
//

import Foundation

enum ServiceError: Error {
    case httpError(error: Error)
    case httpError(code: Int?)
    case decodingError
    case noDataError
    case urlError
}

enum ServiceURL {
    case questions
    
    var path: String {
        switch self {
        case .questions: return "questions"
        }
    }
}

protocol ServiceProtocol {
    func getQuestions(completion: @escaping ((Result<[Question], ServiceError>) -> ()))
}

final class Service: ServiceProtocol {
    
    private let network: NetworkProtocol
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func getQuestions(completion: @escaping ((Result<[Question], ServiceError>) -> ())) {
        //return network.fetch(endpoint: ServiceURL.questions.path, completion: completion)
        completion(.success(Question.stubbed()))
    }
}
