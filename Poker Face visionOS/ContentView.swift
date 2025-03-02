//
//  ContentView.swift
//  Poker Face visionOS
//
//  Created by Alex Baratti on 3/2/25.
//

import SwiftUI

struct ContentView: View {
    @State var showQuickReference = false
    @State var selectedGame: Game? = nil
    
    @Binding var openWindows: Set<String>
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.openWindow) private var openWindow
    
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
            .navigationTitle("Poker Reference")
            .toolbar {
                ToolbarItem(placement: sizeClass == .compact ? .topBarLeading : .topBarTrailing, content: {
                    Button(action: {
                        if !openWindows.contains("quick-reference") {
                            openWindow(id: "quick-reference")
                            openWindows.insert("quick-reference")
                        }
                    }, label: {
                        Label("Quick Reference", systemImage: "rectangle.portrait.on.rectangle.portrait.angled")
                    })
                    .disabled(openWindows.contains("quick-reference"))
                })
            }
        }, detail: {
            if selectedGame != nil {
                GameDetailView(game: selectedGame!, showQuickReference: $showQuickReference, openWindows: $openWindows)
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
    }
}
#Preview(windowStyle: .automatic) {
    ContentView(openWindows: .constant([]))
}
