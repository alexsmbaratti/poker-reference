//
//  QuickReferenceView.swift
//  Poker Face
//
//  Created by Alex Baratti on 12/11/22.
//

import SwiftUI

struct QuickReferenceView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HandReferenceView(name: "Royal Flush", description: "Five cards of the same suit in sequence", cards: [Card(rank: .ace, suit: .heart), Card(rank: .king, suit: .heart), Card(rank: .queen, suit: .heart), Card(rank: .jack, suit: .heart), Card(rank: .ten, suit: .heart)])
                Divider()
                HandReferenceView(name: "Straight Flush", description: "Five cards of the same suit in sequence", cards: [Card(rank: .ace, suit: .heart), Card(rank: .king, suit: .heart), Card(rank: .queen, suit: .heart), Card(rank: .jack, suit: .heart), Card(rank: .ten, suit: .heart)])
                Divider()
                HandReferenceView(name: "4 Of A Kind", description: "Four cards of the same rank, plus an unmatched card", cards: [Card(rank: .ace, suit: .heart), Card(rank: .king, suit: .heart), Card(rank: .queen, suit: .heart), Card(rank: .jack, suit: .heart), Card(rank: .ten, suit: .heart)])
                Divider()
                HandReferenceView(name: "Full House", description: "Three matching cards of one rank, with two matching cards of another", cards: [Card(rank: .ace, suit: .heart), Card(rank: .king, suit: .heart), Card(rank: .queen, suit: .heart), Card(rank: .jack, suit: .heart), Card(rank: .ten, suit: .heart)])
                Divider()
                HandReferenceView(name: "Flush", description: "Five cards of the same suit, but not in sequence", cards: [Card(rank: .ace, suit: .heart), Card(rank: .king, suit: .heart), Card(rank: .queen, suit: .heart), Card(rank: .jack, suit: .heart), Card(rank: .ten, suit: .heart)])
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        isShowing = false
                    }, label: {
                        Text("Done")
                    })
                })
            }
            .padding(.all)
            .navigationTitle("Quick Reference")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HandReferenceView: View {
    var name: String
    var description: String
    var cards: [Card]
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text(name)
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text(description)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
                .multilineTextAlignment(.leading)
                CardStack()
            }
            Spacer()
        }
    }
}

struct CardStack: View {
    var body: some View {
        ZStack {
            CardView(card: Card(rank: .ace, suit: .heart))
            CardView(card: Card(rank: .king, suit: .heart))
                .offset(x: 25)
            CardView(card: Card(rank: .queen, suit: .heart))
                .offset(x: 50)
            CardView(card: Card(rank: .jack, suit: .heart))
                .offset(x: 75)
            CardView(card: Card(rank: .ten, suit: .heart))
                .offset(x: 100)
        }
        .offset(x: -50)
        .frame(width: 200, height: 125)
    }
}

struct CardView: View {
    var card: Card
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.white)
                .shadow(radius: 5)
            HStack {
                VStack {
                    Text(card.rank.symbol)
                        .fontWeight(.bold)
                    .foregroundColor(.black)
                    Image(systemName: card.suit.symbol)
                        .foregroundColor(card.suit.color)
                    Spacer()
                }
                .dynamicTypeSize(.medium)
                Spacer()
            }
            .padding(.all, 3.0)
        }
        .frame(width: 70, height: 100)
    }
}

struct QuickReferenceView_Previews: PreviewProvider {
    static var previews: some View {
        QuickReferenceView(isShowing: .constant(true))
    }
}
