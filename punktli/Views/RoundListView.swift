//
//  RoundListView.swift
//  punktli
//
//  Created by Dominik Hofer on 29.08.22.
//

import SwiftUI

struct RoundListView: View {
    @EnvironmentObject private var gameViewModel: GameViewModel
    
    var body: some View {
        NavigationStack {
            List {
                if gameViewModel.rounds.count > 0 {
                    ForEach(gameViewModel.rounds) { round in
                        VStack(alignment: .leading) {
                            Text("Round \((gameViewModel.rounds.firstIndex(of: round) ?? 0) + 1)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            HStack(alignment: .firstTextBaseline) {
                                HStack(alignment: .center) {
                                    Text(gameViewModel.team1.emoji)
                                        .background(
                                            Circle()
                                                .fill(Color("AccentColorLight"))
                                                .frame(width: 32, height: 32)
                                        )
                                    
                                    Text(String(round.team1Points))
                                        .font(.subheadline)
                                        .padding(.leading, 8)
                                }
                                
                                Spacer()
                                
                                HStack(alignment: .center) {
                                    
                                    Text(String(round.team2Points))
                                        .font(.subheadline)
                                        .padding(.trailing, 8)
                                    
                                    Text(gameViewModel.team2.emoji)
                                        .background(
                                            Circle()
                                                .fill(Color("AccentColorLight"))
                                                .frame(width: 32, height: 32)
                                        )
                                }
                            }
                            .padding(.top, 8)
                        }
                    }
                    .onDelete(perform: gameViewModel.deleteRound)
                } else {
                    Text("No Rounds entered yet…")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Rounds")
        }
    }
}

struct RoundListView_Previews: PreviewProvider {
    static var previews: some View {
        RoundListView()
            .environmentObject(GameViewModel())
    }
}
