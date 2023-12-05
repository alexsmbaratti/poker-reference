//
//  ContentView.swift
//  Poker Face
//
//  Created by Alex Baratti on 12/11/22.
//

import SwiftUI

struct ContentView: View {
    @State var showQuickReference = false
    @State var selectedGame: Game? = nil
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        NavigationSplitView(sidebar: {
            VStack {
                List(selection: $selectedGame) {
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
            .navigationTitle("Poker Face")
            .toolbar {
                ToolbarItem(placement: sizeClass == .compact ? .topBarLeading : .topBarTrailing, content: {
                    Button(action: {
                        showQuickReference = true
                    }, label: {
                        Label("Quick Reference", systemImage: "rectangle.portrait.on.rectangle.portrait.angled")
                    })
                })
            }
        }, detail: {
            if selectedGame != nil {
                GameDetailView(game: selectedGame!)
            } else {
                VStack {
                    Spacer()
                    CardView(card: Card(rank: .king, suit: .heart, side: .face_up))
                        .padding(.all)
                    Text("Select a Game")
                        .font(.title)
                        .bold()
                    if sizeClass != .compact {
                        Text("Tap the icon in the top left corner to reveal the game drawer")
                            .font(.title2)
                    }
                    Spacer()
                }
            }
        })
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
