//
//  GameView.swift
//  punktli
//
//  Created by Dominik Hofer on 29.08.22.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject private var gameViewModel: GameViewModel
    
    private var score1: Int {
        var score = 0
        
        for round in gameViewModel.rounds {
            score += round.team1Points
        }
        
        return score
    }
    
    private var score2: Int {
        var score = 0
        
        for round in gameViewModel.rounds {
            score += round.team2Points
        }
        
        return score
    }
    
    @State private var showingResetAlert = false
    @State private var showingRoundSheet = false
    @State private var showingSettingsSheet = false
    @State private var calculateOppositeScore = true
    
    @State private var tempScore1: Int = 0
    @State private var tempScore2: Int = 0
    
    @State private var tempTeam1DoubleWin: Bool = false
    @State private var tempTeam1Tichu: Bool = false
    @State private var tempTeam1FailedTichu: Bool = false
    @State private var tempTeam1BigTichu: Bool = false
    @State private var tempTeam1FailedBigTichu: Bool = false
    @State private var tempTeam2DoubleWin: Bool = false
    @State private var tempTeam2Tichu: Bool = false
    @State private var tempTeam2FailedTichu: Bool = false
    @State private var tempTeam2BigTichu: Bool = false
    @State private var tempTeam2FailedBigTichu: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                TeamScoreView(team: gameViewModel.team1, score: score1)
                
                Spacer()
                
                TeamScoreView(team: gameViewModel.team2, score: score2)
            }
            .padding(.top)
            
            
            
            List {
                Section("Enter Round Data") {
                    HStack {
                        Text(String(tempScore1))
                        
                        Stepper("Team 1 Score", value: $tempScore1, in: -25...125, step: 5)
                            .onChange(of: tempScore1) { newValue in
                                if calculateOppositeScore {
                                    changeScore(of: 2, value: newValue)
                                }
                            }
                        
                        Spacer()
                        
                        Stepper("Team 2 Score", value: $tempScore2, in: -25...125, step: 5)
                            .onChange(of: tempScore2) { newValue in
                                if calculateOppositeScore {
                                    changeScore(of: 1, value: newValue)
                                }
                            }
                        
                        Text(String(tempScore2))
                    }
                    
                    ScoreToggleView(title: "Double Win", bool1: $tempTeam1DoubleWin, bool2: $tempTeam2DoubleWin)
                    
                    ScoreToggleView(title: "Tichu", bool1: $tempTeam1Tichu, bool2: $tempTeam2Tichu)
                    
                    ScoreToggleView(title: "Failed Tichu", bool1: $tempTeam1FailedTichu, bool2: $tempTeam2FailedTichu)
                    
                    ScoreToggleView(title: "Big Tichu", bool1: $tempTeam1BigTichu, bool2: $tempTeam2BigTichu)
                    
                    ScoreToggleView(title: "Failed Big Tichu", bool1: $tempTeam1FailedBigTichu, bool2: $tempTeam2FailedBigTichu)
                }
                .listRowSeparator(.hidden)
                
                Section {
                    HStack {
                        Spacer()
                        
                        Button("Show Rounds") {
                            showingRoundSheet = true
                        }
                        .buttonStyle(.bordered)
                        .tint(.accentColor)
                        .foregroundColor(.black)
                        
                        Button("Save Round") {
                            Task {
                                await saveRound()
                            }
                        }
                        .disabled(tempScore1 == 0 && tempScore2 == 0 && tempTeam1DoubleWin == false && tempTeam2DoubleWin == false)
                        .buttonStyle(.borderedProminent)
                        .bold()
                        .foregroundColor(.black)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .padding(.top)
                }
            }
            .listStyle(.plain)
            .font(.subheadline.bold())
            .labelsHidden()
        }
        .padding()
        .navigationTitle("观点")
        .toolbar {
            ToolbarItemGroup {
                Button() {
                    showingResetAlert = true
                } label: {
                    Image(systemName: "arrow.clockwise.circle")
                }
                
                Button() {
                    showingSettingsSheet = true
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
        .alert("Reset Game?", isPresented: $showingResetAlert) {
            Button("No, cancel!", role: .cancel) { }
            
            Button("Yes, I'm sure!", role: .destructive) {
                gameViewModel.resetGame()
            }
        }
        .sheet(isPresented: $showingRoundSheet) {
            RoundListView()
                .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $showingSettingsSheet) {
            SettingsView()
        }
    }
    
    func changeScore(of name: Int, value: Int) {
        let otherScore = 100 - value
        
        if(name == 1) {
            tempScore1 = otherScore
        } else {
            tempScore2 = otherScore
        }
    }
    
    func saveRound() async {
        var calculatedScore1 = tempScore1
        var calculatedScore2 = tempScore2
        
        if tempTeam1DoubleWin {
            calculatedScore1 = 200
            calculatedScore2 = 0
        }
        
        if tempTeam1Tichu {
            calculatedScore1 += 100
        }
        
        if tempTeam1FailedTichu {
            calculatedScore1 -= 100
        }
        
        if tempTeam1BigTichu {
            calculatedScore1 += 200
        }
        
        if tempTeam1FailedBigTichu {
            calculatedScore1 -= 200
        }
        
        if tempTeam2DoubleWin {
            calculatedScore1 = 0
            calculatedScore2 = 200
        }
        
        if tempTeam2Tichu {
            calculatedScore2 += 100
        }
        
        if tempTeam2FailedTichu {
            calculatedScore2 -= 100
        }
        
        if tempTeam2BigTichu {
            calculatedScore2 += 200
        }
        
        if tempTeam2FailedBigTichu {
            calculatedScore2 -= 200
        }
        
        let newRound = Round(createdAt: Date.now, team1Points: calculatedScore1, team1DoubleWin: tempTeam1DoubleWin, team1Tichu: tempTeam1Tichu, team1FailedTichu: tempTeam1FailedTichu, team1BigTichu: tempTeam1BigTichu, team1FailedBigTichu: tempTeam1FailedBigTichu, team2Points: calculatedScore2, team2DoubleWin: tempTeam2DoubleWin, team2Tichu: tempTeam2Tichu, team2FailedTichu: tempTeam2FailedTichu, team2BigTichu: tempTeam2BigTichu, team2FailedBigTichu: tempTeam2FailedBigTichu)
        
        gameViewModel.rounds.append(newRound)
        
        print("Round saved")
        calculateOppositeScore = false
        
        await resetValues()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            calculateOppositeScore = true
        }
    }
    
    func resetValues() async {
        tempScore1 = 0
        tempTeam1DoubleWin = false
        tempTeam1Tichu = false
        tempTeam1FailedTichu = false
        tempTeam1BigTichu = false
        tempTeam1FailedBigTichu = false
        
        tempScore2 = 0
        tempTeam2DoubleWin = false
        tempTeam2Tichu = false
        tempTeam2FailedTichu = false
        tempTeam2BigTichu = false
        tempTeam2FailedBigTichu = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GameView()
        }
        .environmentObject(GameViewModel())
    }
}
