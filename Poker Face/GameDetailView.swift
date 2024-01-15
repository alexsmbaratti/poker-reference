//
//  GameView.swift
//  Poker Face
//
//  Created by Alex Baratti on 12/14/22.
//

import SwiftUI

struct GameDetailView: View {
    var game: Game
    
    @Binding var showQuickReference: Bool
    @Binding var openWindows: Set<String>
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        ScrollView {
            Group {
                // TODO: Add winning hand and special cards sections
                if game.hasWilds() {
                    Heading(text: "Wild Cards")
                    CardBunchReferenceView(cardBunches: game.getAllWildCards())
                }
                if game.hasWinningHands() {
                    Heading(text: "Winning Hands")
                    CardBunchReferenceView(cardBunches: game.winningHands)
                }
                Heading(text: "How to Play")
                HowToView(steps: game.steps, showQuickReference: $showQuickReference, openWindows: $openWindows)
                if game.hasVariants() {
                    Heading(text: "Variants")
                    VariantsView(variants: game.variants)
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitle(game.name)
    }
}

struct HowToView: View {
    var steps: [Instruction]
    
    @Binding var showQuickReference: Bool
    @Binding var openWindows: Set<String>
    
    var body: some View {
        if !steps.isEmpty {
            VStack {
                ForEach(0..<steps.count, id: \.self) { index in
                    StepView(num: index + 1, step: steps[index], showQuickReference: $showQuickReference, openWindows: $openWindows)
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

struct CardBunchReferenceView: View {
    var cardBunches: [CardBunch]
    
    var body: some View {
        VStack {
            ForEach(cardBunches, id: \.self) { cardBunch in
                CardBunchView(text: cardBunch.description, cards: cardBunch.cards)
            }
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

struct CardBunchView: View {
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
                if !cards.isEmpty {
                    CardStackView(cards: cards)
                        .scaleEffect(0.7)
                }
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
    @Binding var openWindows: Set<String>
    
    @Environment(\.colorScheme) var colorScheme
#if !os(iOS)
    @Environment(\.openWindow) private var openWindow
#endif
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundStyle(.quaternary)
                Text(String(num))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
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
#if !os(iOS)
                            if !openWindows.contains("quick-reference") {
                                openWindow(id: "quick-reference")
                                openWindows.insert("quick-reference")
                            }
#else
                            showQuickReference = true
#endif
                        }) {
                            Label("Quick Reference", systemImage: "rectangle.portrait.on.rectangle.portrait.angled")
                                .fontWeight(.semibold)
                                .font(.headline)
                                .padding()
#if !os(visionOS)
                                .foregroundColor(.white) // Needed to prevent green text on iOS
                                .background(.primary) // Needed to give button accent color on iOS
#else
                                .backgroundStyle(.primary)
#endif
                                .cornerRadius(20)
                        }
#if !os(iOS)
                        .disabled(openWindows.contains("quick-reference"))
#endif
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
            GameDetailView(game: Game(name: "My Poker Game", steps: [Instruction(description: "First", subtext: "Subtext"), Instruction(description: "Second"), Instruction(description: "Third", subtext: "Subtext", offerQuickReference: true)], wildRanks: [.seven, .nine], wildCards: [Card(rank: .queen, suit: .heart)], wildCustoms: ["Some Wild Cards"], variants: [Variant(name: "My Variant", description: "Description")]), showQuickReference: .constant(false), openWindows: .constant([]))
        }
    }
}
