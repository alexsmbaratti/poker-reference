//
//  GameView.swift
//  Poker Face
//
//  Created by Alex Baratti on 12/14/22.
//

import SwiftUI

struct GameDetailView: View {
    var game: Game
    
    var body: some View {
        VStack {
            Text("Placeholder")
        }
        .navigationBarTitle(game.name)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(game: Game(name: "My Poker Game"))
    }
}
