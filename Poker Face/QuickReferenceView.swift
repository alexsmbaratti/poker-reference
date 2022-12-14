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
                ForEach(Hand.allCases, id: \.rawValue) { hand in
                    HandReferenceView(hand: hand)
                    Divider()
                }
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
            .padding(.horizontal)
            .navigationTitle("Quick Reference")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HandReferenceView: View {
    var hand: Hand
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text(hand.name)
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text(hand.description)
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
                .multilineTextAlignment(.leading)
                CardStackView(cards: hand.exampleHand)
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
                    label
                    Spacer()
                }
                .dynamicTypeSize(.medium)
                Spacer()
                VStack {
                    label
                    Spacer()
                }
                .rotationEffect(.degrees(180))
            }
            .padding(.all, 3.0)
        }
        .frame(width: 70, height: 100)
    }
    
    var label: some View {
        VStack {
            Text(card.rank.symbol)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Image(systemName: card.suit.symbol)
                .foregroundColor(card.suit.color)
        }
    }
}

struct QuickReferenceView_Previews: PreviewProvider {
    static var previews: some View {
        QuickReferenceView(isShowing: .constant(true))
    }
}
