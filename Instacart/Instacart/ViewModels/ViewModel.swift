//
//  ViewModel.swift
//  Instacart
//
//  Created by Rushi Bhatt on 1/24/23.
//

import Foundation

protocol ViewModelProtocol {
    var questions: [Question]? { get }
    var imageCellViewModels: [ImageCellViewModel] { get set }
    func fetchQuestions(completion: @escaping ((Result<Void, Error>) -> ()))
    func onSubmit(completion: @escaping ((Bool) -> ()))
    func navigate() 
}

final class ViewModel: ViewModelProtocol {
    
    var questions: [Question]?
    
    private let service: ServiceProtocol
    private let router: RoutingProtocol
    
    var imageCellViewModels: [ImageCellViewModel] = []
    
    init(service: ServiceProtocol, router: RoutingProtocol) {
        self.service = service
        self.router = router
    }
    
    func fetchQuestions(completion: @escaping ((Result<Void, Error>) -> ())) {
        service.getQuestions { [weak self] result in
            switch result {
            case .success(let questions):
                self?.questions = questions
                self?.makeCellViewModels()
                completion(.success(()))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func makeCellViewModels() {
        guard let answers = questions?.first?.answers else { return }
        for answer in answers {
            imageCellViewModels.append(.init(with: answer))
        }
    }
    
    func onSubmit(completion: @escaping ((Bool) -> ())) {
        guard imageCellViewModels.filter({ $0.isChosen }).count == 1 else {
            print("select 1 option")
            return
        }
        
        if imageCellViewModels.filter({ $0.isChosen && $0.isCorrect }).count != 0 {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func navigate() {
        router.navigateToDummyVC()
    }
}
