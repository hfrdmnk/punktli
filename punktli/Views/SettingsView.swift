//
//  SettingsView.swift
//  punktli
//
//  Created by Dominik Hofer on 30.08.22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var gameViewModel: GameViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var team1Name = ""
    @State private var team2Name = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Change team names") {
                    TextField("Enter new Team 1 Name", text: $team1Name)
                    
                    TextField("Enter new Team 2 Name", text: $team2Name)
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        Button("Save Names", action: saveSettings)
                        .buttonStyle(.borderedProminent)
                        .bold()
                        .foregroundColor(.black)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    func saveSettings() {
        if !team1Name.isEmpty {
            gameViewModel.team1.name = team1Name
        }
        
        if !team2Name.isEmpty {
            gameViewModel.team2.name = team2Name
        }
        
        dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(GameViewModel())
    }
}
