//
//  TeamModel.swift
//  punktli
//
//  Created by Dominik Hofer on 29.08.22.
//

import Foundation

struct Team: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var emoji: String
    var points: Int = 0
}
