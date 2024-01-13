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
#if !os(iOS)
    @Environment(\.openWindow) private var openWindow
#endif
    
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
#if !os(iOS)
                        if !Poker_FaceApp.openWindows.contains("quick-reference") {
                            openWindow(id: "quick-reference")
                            Poker_FaceApp.openWindows.insert("quick-reference")
                        }
#else
                        showQuickReference = true
#endif
                    }, label: {
                        Label("Quick Reference", systemImage: "rectangle.portrait.on.rectangle.portrait.angled")
                    })
                })
            }
        }, detail: {
            if selectedGame != nil {
                GameDetailView(game: selectedGame!, showQuickReference: $showQuickReference)
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
#if os(iOS)
        .sheet(isPresented: $showQuickReference, content: {
            QuickReferenceView(isShowing: $showQuickReference)
        })
#endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
