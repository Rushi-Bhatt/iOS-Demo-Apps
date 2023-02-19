//
//  extension.swift
//  Covid Tracker
//
//  Created by Rushi Bhatt on 11/14/21.
//

import Foundation

extension DateFormatter {
  static let dayFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd"
    formatter.locale = .current
    formatter.timeZone = .current
    return formatter
  }()
}

extension NumberFormatter {
  static let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
  }()
}

