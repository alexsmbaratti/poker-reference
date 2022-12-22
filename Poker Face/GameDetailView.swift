//
//  GameView.swift
//  Poker Face
//
//  Created by Alex Baratti on 12/14/22.
//

import SwiftUI

struct GameDetailView: View {
    var game: Game
    
    @State var showQuickReference = false
    
    var body: some View {
        ScrollView {
            Heading(text: "Wildcards")
            WildcardsView(game: game)
            Heading(text: "How to Play")
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ullamcorper orci sit amet euismod accumsan. Proin mi urna, ultrices in elementum porttitor, blandit sit amet turpis.")
            Heading(text: "Win Condition")
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ullamcorper orci sit amet euismod accumsan. Proin mi urna, ultrices in elementum porttitor, blandit sit amet turpis.")
            Button(action: {
                showQuickReference = true
            }) {
                Text("Show Quick Reference")
                    .fontWeight(.semibold)
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(.cyan)
                    .cornerRadius(20)
            }
            Heading(text: "Variants")
            VariantsView(game: game)
        }
        .padding(.horizontal)
        .navigationBarTitle(game.name)
        .sheet(isPresented: $showQuickReference, content: {
            QuickReferenceView(isShowing: $showQuickReference)
        })
    }
}

struct VariantsView: View {
    var game: Game
    
    var body: some View {
        if game.hasVariants() {
            VStack {
                ForEach(game.variants, id: \.self) { variant in
                    VariantView(variant: variant)
                }
            }
            .padding(.all)
            .aspectRatio(contentMode: .fit)
            .background(
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .foregroundColor(Color(.systemFill))
                    .shadow(radius: 7)
            )
        } else {
            HStack {
                Spacer()
                Text("No Variants")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.all)
            .aspectRatio(contentMode: .fit)
            .background(
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .foregroundColor(Color(.systemFill))
                    .shadow(radius: 7)
            )
        }
    }
}

struct WildcardsView: View {
    var game: Game
    
    var body: some View {
        VStack {
            if (game.hasWilds()) {
                VStack {
                    ForEach(game.wildranks, id: \.self) { rank in
                        WildsReferenceView(text: rank.descriptionPlural, cards: rank.allSuits)
                    }
                    ForEach(game.wildcards, id: \.self) { card in
                        WildsReferenceView(text: card.description, cards: [card])
                    }
                }
                .padding(.all)
                .aspectRatio(contentMode: .fit)
                .background(
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .foregroundColor(Color(.systemFill))
                        .shadow(radius: 7)
                )
            } else {
                HStack {
                    Spacer()
                    Text("No Wildcards")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.all)
                .aspectRatio(contentMode: .fit)
                .background(
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .foregroundColor(Color(.systemFill))
                        .shadow(radius: 7)
                )
            }
        }
    }
}

struct VariantView: View {
    var variant: Variant
    
    var body: some View {
        VStack {
            HStack {
                Text(variant.name)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            Text(variant.description)
                .multilineTextAlignment(.leading)
        }
        .padding(.all)
        .aspectRatio(contentMode: .fit)
        .background(
            RoundedRectangle(cornerRadius: 4, style: .continuous)
                .foregroundColor(Color(.systemFill))
                .shadow(radius: 7)
        )
    }
}

struct WildsReferenceView: View {
    var text: String
    var cards: [Card]
    
    var body: some View {
        VStack {
            HStack {
                Text(text)
                    .font(.title3)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Spacer()
                CardStackView(cards: cards)
                    .scaleEffect(0.7)
            }
        }
        .frame(height: 80)
    }
}

private struct Heading: View {
    var text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GameDetailView(game: Game(name: "My Poker Game", wildranks: [.seven, .nine], wildcards: [Card(rank: .queen, suit: .heart)]))
        }
    }
}
