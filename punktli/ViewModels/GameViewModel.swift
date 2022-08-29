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
    @Published var team1: Team = Team(name: "Dragons", emoji: "🐉") {
        didSet {
            saveData()
        }
    }
    
    @Published var team2: Team = Team(name: "Jokers", emoji: "🃏") {
        didSet {
            saveData()
        }
    }
    
    @Published var rounds: [Round] = [] {
        didSet {
            saveData()
        }
    }
    let team1Key: String = "team1"
    let team2Key: String = "team2"
    let roundsKey: String = "rounds"
    
    init() {
        getData()
    }
    
    func getData() {
        guard
            let team1 = UserDefaults.standard.data(forKey: team1Key),
            let savedTeam1 = try? JSONDecoder().decode(Team.self, from: team1)
        else { return }
        
        guard
            let team2 = UserDefaults.standard.data(forKey: team2Key),
            let savedTeam2 = try? JSONDecoder().decode(Team.self, from: team2)
        else { return }
        
        guard
            let rounds = UserDefaults.standard.data(forKey: roundsKey),
            let savedRounds = try? JSONDecoder().decode([Round].self, from: rounds)
        else { return }
        
        self.team1 = savedTeam1
        self.team2 = savedTeam2
        self.rounds = savedRounds
    }
    
    func saveData() {
        if let encodedTeam1 = try? JSONEncoder().encode(team1) {
            UserDefaults.standard.set(encodedTeam1, forKey: team1Key)
        }
        
        if let encodedTeam2 = try? JSONEncoder().encode(team2) {
            UserDefaults.standard.set(encodedTeam2, forKey: team2Key)
        }
        
        if let encodedRounds = try? JSONEncoder().encode(rounds) {
            UserDefaults.standard.set(encodedRounds, forKey: roundsKey)
        }
    }
}
