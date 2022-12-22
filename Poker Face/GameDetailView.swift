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
            HowToView(steps: game.steps)
            Heading(text: "Variants")
            VariantsView(variants: game.variants)
        }
        .padding(.horizontal)
        .navigationBarTitle(game.name)
        .sheet(isPresented: $showQuickReference, content: {
            QuickReferenceView(isShowing: $showQuickReference)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(action: {
                    showQuickReference = true
                }, label: {
                    Label("Quick Reference", systemImage: "rectangle.portrait.on.rectangle.portrait.angled")
                })
            })
        }
    }
}

struct HowToView: View {
    var steps: [Instruction]
    
    var body: some View {
        if !steps.isEmpty {
            VStack {
                ForEach(0..<steps.count, id: \.self) { index in
                    StepView(num: index + 1, step: steps[index])
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
                Text("No Steps")
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

struct VariantsView: View {
    var variants: [Variant]
    
    var body: some View {
        if !variants.isEmpty {
            VStack {
                ForEach(variants, id: \.self) { variant in
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

struct StepView: View {
    var num: Int
    var step: Instruction
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(colorScheme == .dark ? .black : .gray)
                Text(String(num))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .frame(height: 50)
            Text(step.description)
                .font(.title3)
                .fontWeight(.bold)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .padding(.leading)
            Spacer()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GameDetailView(game: Game(name: "My Poker Game", steps: [Instruction(description: "First"), Instruction(description: "Second")], wildranks: [.seven, .nine], wildcards: [Card(rank: .queen, suit: .heart)]))
        }
    }
}
