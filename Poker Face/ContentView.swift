//
//  ContentView.swift
//  Poker Face
//
//  Created by Alex Baratti on 12/11/22.
//

import SwiftUI

struct ContentView: View {
    @State var showQuickReference = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
