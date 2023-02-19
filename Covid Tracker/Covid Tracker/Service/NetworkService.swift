//
//  NetworkService.swift
//  Covid Tracker
//
//  Created by Rushi Bhatt on 11/13/21.
//

import Foundation

final class NetworkService {
  
  static let shared = NetworkService()
  
  let statesURL = URL(string: "https://api.covidtracking.com/v2/states.json")

  private init() {}
  
  func getCovidData(for scope: DataScope, completion: @escaping (Result<[DayWiseData], Error>) -> Void) {
    let urlStringValue: String?
    switch scope {
    case .national:
      urlStringValue = "https://api.covidtracking.com/v2/us/daily.json"
    case .state(let state):
      urlStringValue = "https://api.covidtracking.com/v2/states/\(state.state_code.lowercased())/daily.json"
   
    }
    guard let urlString = urlStringValue,
          let url = URL(string: urlString) else { return }
    let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
      guard let data = data, error == nil else { return }
      do {
        let response = try JSONDecoder().decode(CovidResponse.self, from: data)
        let covidData = response.data
        print(covidData)
        // Conver [CovidData] to DayWiseData
        let dayWiseData: [DayWiseData] = covidData.compactMap {
          guard let count = $0.cases?.total?.value,
                let date = DateFormatter.dayFormatter.date(from: $0.date) else { return nil }
          return DayWiseData(date: date, count: count)
      }
        completion(.success(dayWiseData))
      } catch {
        completion(.failure(error))
      }
    }
    task.resume()
  }
  
  func getAllStates(completion: @escaping (Result<[State], Error>) -> Void) {
    guard let url = statesURL else { return }
    let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
      guard let data = data, error == nil else { return }
      do {
        let stateResponse = try JSONDecoder().decode(StateResponse.self, from: data)
        completion(.success(stateResponse.data))
      } catch {
        completion(.failure(error))
      }
    }
    task.resume()
  }
  
}
