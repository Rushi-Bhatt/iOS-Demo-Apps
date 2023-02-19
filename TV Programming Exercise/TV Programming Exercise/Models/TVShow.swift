//
//  TVShow.swift
//  TV Programming Exercise
//
//  Created by Jeffery Kuo on 12/17/19.
//  Copyright © 2019 Jeffery Kuo. All rights reserved.
//

import Foundation

struct PopularShowsResponse: Codable {
    let results: [TVShow]
}

struct TVShow: Codable {
    let id: Int
    let name: String
    let first_air_date: String
    let vote_average: Double
}
