//
//  ContentView.swift
//  Poker Face watchOS Watch App
//
//  Created by Alex Baratti on 3/2/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HandsView()
    }
}

struct HandsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(Hand.allCases, id: \.rawValue) { hand in
                    VStack {
                        CardStackView(cards: hand.exampleHand)
                        Text(hand.name)
                            .font(.headline)
                            .foregroundStyle(.gray)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    ContentView()
}
