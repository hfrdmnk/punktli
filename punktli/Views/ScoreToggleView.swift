//
//  ScoreToggleView.swift
//  punktli
//
//  Created by Dominik Hofer on 29.08.22.
//

import SwiftUI

struct ScoreToggleView: View {
    let title: String
    @Binding var bool1: Bool
    @Binding var bool2: Bool
    
    
    var body: some View {
        HStack {
            Toggle("Team 1 \(title)", isOn: $bool1)
            
            Spacer()
            
            Text(title)
            
            Spacer()
            
            Toggle("Team 2 \(title)", isOn: $bool2)
        }
    }
}
