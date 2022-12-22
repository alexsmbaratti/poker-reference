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
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(games) { game in
                        NavigationLink(value: game, label: {
                            HStack {
                                Text(game.name)
                                Spacer()
                            }
                        })
                    }
                }
                .listStyle(.inset)
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
                        Label("Quick Reference", systemImage: "rectangle.portrait.on.rectangle.portrait.angled")
                    })
                })
            }
        }
        .sheet(isPresented: $showQuickReference, content: {
            QuickReferenceView(isShowing: $showQuickReference)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
