//
//  GameView.swift
//  punktli
//
//  Created by Dominik Hofer on 29.08.22.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
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
