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
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        ScrollView {
            if sizeClass == .compact {
                Group {
                    Heading(text: "Wildcards")
                    WildcardsView(game: game)
                    Heading(text: "How to Play")
                    HowToView(steps: game.steps, showQuickReference: $showQuickReference)
                    if game.hasVariants() {
                        Heading(text: "Variants")
                        VariantsView(variants: game.variants)
                    }
                }
                .padding(.horizontal)
            } else {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    VStack(alignment: .leading, spacing: 16) {
                        Heading(text: "Wildcards")
                        WildcardsView(game: game)
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Heading(text: "How to Play")
                        HowToView(steps: game.steps, showQuickReference: $showQuickReference)
                        if game.hasVariants() {
                            VStack(alignment: .leading, spacing: 16) {
                                Heading(text: "Variants")
                                VariantsView(variants: game.variants)
                            }
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle(game.name)
        .sheet(isPresented: $showQuickReference, content: {
            QuickReferenceView(isShowing: $showQuickReference)
        })
    }
}

struct HowToView: View {
    var steps: [Instruction]
    
    @Binding var showQuickReference: Bool
    
    var body: some View {
        if !steps.isEmpty {
            VStack {
                ForEach(0..<steps.count, id: \.self) { index in
                    StepView(num: index + 1, step: steps[index], showQuickReference: $showQuickReference)
                }
            }
            .padding(.all)
            .aspectRatio(contentMode: .fill)
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
            .aspectRatio(contentMode: .fill)
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
            .aspectRatio(contentMode: .fill)
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
            .aspectRatio(contentMode: .fill)
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
                .aspectRatio(contentMode: .fill)
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
                .aspectRatio(contentMode: .fill)
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
            HStack {
                Text(variant.description)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
        }
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
    
    @Binding var showQuickReference: Bool
    
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
            VStack {
                HStack {
                    Text(step.description)
                        .font(.title3)
                        .fontWeight(.bold)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                if step.subtext != nil {
                    HStack {
                        Text(step.subtext!)
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
                if step.offerQuickReference != nil && step.offerQuickReference! {
                    HStack {
                        Button(action: {
                            showQuickReference = true
                        }) {
                            Label("Quick Reference", systemImage: "rectangle.portrait.on.rectangle.portrait.angled")
                                .fontWeight(.semibold)
                                .font(.headline)
                                .padding()
                                .foregroundColor(.white)
                                .background(.primary)
                                .cornerRadius(20)
                        }
                        Spacer()
                    }
                }
            }
            .padding(.leading)
            Spacer()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GameDetailView(game: Game(name: "My Poker Game", steps: [Instruction(description: "First", subtext: "Subtext"), Instruction(description: "Second"), Instruction(description: "Third", subtext: "Subtext", offerQuickReference: true)], wildranks: [.seven, .nine], wildcards: [Card(rank: .queen, suit: .heart)], variants: [Variant(name: "My Variant", description: "Description")]))
        }
    }
}
