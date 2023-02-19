//
//  TVShowDetails.swift
//  TV Programming Exercise
//
//  Created by Jeffery Kuo on 4/16/21.
//  Copyright © 2021 Jeffery Kuo. All rights reserved.
//

import Foundation

struct Genre: Codable {
    let name: String
}

struct TVShowDetails: Codable {
    let name: String
    let genres: [Genre]
    let overview: String
}
