//
//  TeamScoreView.swift
//  punktli
//
//  Created by Dominik Hofer on 29.08.22.
//

import SwiftUI

struct TeamScoreView: View {
    let team: Team
    let score: Int
    
    var body: some View {
        VStack {
            Text(team.emoji)
                .font(.largeTitle)
                .background(
                    Circle()
                        .fill(Color("AccentColorLight"))
                        .frame(width: 64, height: 64)
                )
                .padding(.bottom, 8)
            Text(team.name)
                .font(.subheadline)
            Text(String(score))
                .font(.largeTitle.bold())
        }    }
}

struct TeamScoreView_Previews: PreviewProvider {
    static var previews: some View {
        TeamScoreView(team: Team(name: "Test", emoji: "💯"), score: 0)
    }
}
