//
//  GameViewModel.swift
//  punktli
//
//  Created by Dominik Hofer on 29.08.22.
//

import Foundation

/*
 CRUD Functions
 
 Create
 Read
 Update
 Delete
 */

class GameViewModel: ObservableObject {
    @Published var teams: [Team] = [] {
        didSet {
            saveData()
        }
    }
    
    @Published var rounds: [Round] = [] {
        didSet {
            saveData()
        }
    }
    let teamsKey: String = "teams"
    let roundsKey: String = "rounds"
    
    init() {
        getData()
    }
    
    func getData() {
        guard
            let teams = UserDefaults.standard.data(forKey: teamsKey),
            let savedTeams = try? JSONDecoder().decode([Team].self, from: teams)
        else { return }
        
        guard
            let rounds = UserDefaults.standard.data(forKey: roundsKey),
            let savedRounds = try? JSONDecoder().decode([Round].self, from: rounds)
        else { return }
        
        self.teams = savedTeams
        self.rounds = savedRounds
    }
    
    func saveData() {
        if let encodedTeams = try? JSONEncoder().encode(teams) {
            UserDefaults.standard.set(encodedTeams, forKey: teamsKey)
        }
        
        if let encodedRounds = try? JSONEncoder().encode(rounds) {
            UserDefaults.standard.set(encodedRounds, forKey: roundsKey)
        }
    }
}
