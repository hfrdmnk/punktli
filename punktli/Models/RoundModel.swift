//
//  RoundModel.swift
//  punktli
//
//  Created by Dominik Hofer on 29.08.22.
//

import Foundation

struct Round: Identifiable, Codable, Equatable {
    var id = UUID()
    var createdAt: Date
    var team1Points: Int
    var team1DoubleWin: Bool = false
    var team1Tichu: Bool = false
    var team1FailedTichu: Bool = false
    var team1BigTichu: Bool = false
    var team1FailedBigTichu: Bool = false
    var team2Points: Int
    var team2DoubleWin: Bool = false
    var team2Tichu: Bool = false
    var team2FailedTichu: Bool = false
    var team2BigTichu: Bool = false
    var team2FailedBigTichu: Bool = false
}
