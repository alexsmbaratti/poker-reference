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
                HandReferenceView(name: "Straight Flush", description: "Five cards of the same suit in sequence", cards: [Card(rank: .nine, suit: .spade), Card(rank: .eight, suit: .spade), Card(rank: .seven, suit: .spade), Card(rank: .six, suit: .spade), Card(rank: .five, suit: .spade)])
                Divider()
                HandReferenceView(name: "4 Of A Kind", description: "Four cards of the same rank, plus an unmatched card", cards: [Card(rank: .seven, suit: .club), Card(rank: .seven, suit: .diamond), Card(rank: .seven, suit: .heart), Card(rank: .seven, suit: .spade), Card(rank: .two, suit: .heart)])
                Divider()
                HandReferenceView(name: "Full House", description: "Three matching cards of one rank, with two matching cards of another", cards: [Card(rank: .queen, suit: .heart), Card(rank: .queen, suit: .spade), Card(rank: .queen, suit: .diamond), Card(rank: .ace, suit: .club), Card(rank: .ace, suit: .heart)])
                Divider()
                HandReferenceView(name: "Flush", description: "Five cards of the same suit, but not in sequence", cards: [Card(rank: .king, suit: .club), Card(rank: .seven, suit: .club), Card(rank: .five, suit: .club), Card(rank: .three, suit: .club), Card(rank: .two, suit: .club)])
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
                CardStackView(cards: cards)
            }
            Spacer()
        }
    }
}

struct CardStackView: View {
    var cards: [Card]
    
    var body: some View {
        ZStack {
            ForEach(0..<cards.count, id: \.self) { index in
                CardView(card: cards[index])
                    .offset(x: CGFloat(25 * index))
            }
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
