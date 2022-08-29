//
//  punktliApp.swift
//  punktli
//
//  Created by Dominik Hofer on 29.08.22.
//

import SwiftUI

@main
struct punktliApp: App {
    @StateObject var gameViewModel: GameViewModel = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                GameView()
            }
            .environmentObject(gameViewModel)
        }
    }
}
