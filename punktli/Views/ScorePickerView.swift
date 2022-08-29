//
//  ScorePickerView.swift
//  punktli
//
//  Created by Dominik Hofer on 29.08.22.
//

import SwiftUI

struct ScorePickerView: View {
    @Binding var score1: Int
    @Binding var score2: Int
    
    var body: some View {
        HStack {
            Text(String(score1))
            
            Stepper("Team 1 Score", value: $score1, in: -25...125, step: 5)
                .onChange(of: score1) { newValue in
                    changeScore(of: 2, value: newValue)
                }
            
            Spacer()
            
            Stepper("Team 2 Score", value: $score2, in: -25...125, step: 5)
                .onChange(of: score2) { newValue in
                    changeScore(of: 1, value: newValue)
                }
            
            Text(String(score1))
        }
    }
    
    func changeScore(of name: Int, value: Int) {
        let otherScore = 100 - value
        
        if(name == 1) {
            score1 = otherScore
        } else {
            score2 = otherScore
        }
    }
}
