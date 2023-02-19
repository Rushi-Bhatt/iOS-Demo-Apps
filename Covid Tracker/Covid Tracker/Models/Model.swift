//
//  Model.swift
//  Covid Tracker
//
//  Created by Rushi Bhatt on 11/13/21.
//

import Foundation


// API URL: https://covidtracking.com/data/api/version-2

enum DataScope {
  case national
  case state(State)
}

struct StateResponse: Codable {
  let data: [State]
}

struct State: Codable {
  let name: String
  let state_code: String
}

struct CovidResponse: Codable {
  let data: [CovidData]
}

struct CovidData: Codable {
  let date: String
  let cases: CovidCase?
}

struct CovidCase: Codable {
  let total: CovidTotalCase?
}

struct CovidTotalCase: Codable {
  let value: Int?
}

struct DayWiseData {
  let date: Date
  let count: Int
}
