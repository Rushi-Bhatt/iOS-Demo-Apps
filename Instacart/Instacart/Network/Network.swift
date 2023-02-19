//
//  Network.swift
//  Instacart
//
//  Created by Rushi Bhatt on 1/24/23.
//

import Foundation

protocol NetworkProtocol {
    func fetch<T: Codable>(endpoint: String, completion: @escaping (Result<T, ServiceError>) -> ()) where T: Decodable
}

final class Network: NetworkProtocol {
    
    private let urlSession: URLSession
    private let baseURL = "https://testURL.com/"
    
    init(_ urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func fetch<T>(endpoint: String, completion: @escaping (Result<T, ServiceError>) -> ()) where T : Decodable {
        guard let url = URL(string: baseURL)?.appendingPathExtension(endpoint) else {
            completion(.failure(.urlError))
            return
        }
        
        let task = urlSession.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                completion(.failure(.httpError(error: error)))
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion(.failure(.httpError(code: (response as? HTTPURLResponse)?.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataError))
                return
            }
            
            guard let response = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
        }
        
        task.resume()
    }
}
