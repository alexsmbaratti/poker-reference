//
//  GameView.swift
//  Poker Face
//
//  Created by Alex Baratti on 12/14/22.
//

import SwiftUI

struct GameDetailView: View {
    var game: Game
    
    @State var showQuickReference = false
    
    var body: some View {
        ScrollView {
            HStack {
                Text("How to Play")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            HStack {
                Text("Win Condition")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            Button(action: {
                showQuickReference = true
            }) {
                Text("Show Quick Reference")
                    .fontWeight(.semibold)
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(.cyan)
                    .cornerRadius(20)
            }
            HStack {
                Text("Wildcards")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            HStack {
                Text("Variants")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
        }
        .padding(.horizontal)
        .navigationBarTitle(game.name)
        .sheet(isPresented: $showQuickReference, content: {
            QuickReferenceView(isShowing: $showQuickReference)
        })
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GameDetailView(game: Game(name: "My Poker Game"))
        }
    }
}
