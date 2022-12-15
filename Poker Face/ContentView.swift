//
//  ContentView.swift
//  Poker Face
//
//  Created by Alex Baratti on 12/11/22.
//

import SwiftUI

struct ContentView: View {
    @State var showQuickReference = false
    @State var path: [Game] = []
    
    var games = [Game(name: "Five Card Draw"), Game(name: "Baseball"), Game(name: "Placeholder"), Game(name: "7-27"), Game(name: "Placeholder"), Game(name: "Placeholder"), Game(name: "Placeholder"), Game(name: "Placeholder"), Game(name: "Placeholder"), Game(name: "Placeholder"), Game(name: "Placeholder"), Game(name: "Placeholder"), Game(name: "Placeholder")]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(games) { game in
                    NavigationLink(value: game, label: {
                        GameReferenceView(game: game)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationDestination(for: Game.self) { game in
                GameDetailView(game: game)
            }
            .navigationTitle("Poker Face")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(action: {
                        showQuickReference = true
                    }, label: {
                        Label("Quick Reference", systemImage: "questionmark.circle")
                    })
                })
            }
        }
        .sheet(isPresented: $showQuickReference, content: {
            QuickReferenceView(isShowing: $showQuickReference)
        })
    }
}

struct GameReferenceView: View {
    var game: Game
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text(game.name)
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text("Placeholder description")
                            .font(.callout)
                            .redacted(reason: .placeholder)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
                .multilineTextAlignment(.leading)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
