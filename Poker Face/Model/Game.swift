//
//  Game.swift
//  Poker Face
//
//  Created by Alex Baratti on 12/14/22.
//

import Foundation

struct Game: Identifiable, Hashable, Codable {
    var id: Int = 0
    var name: String
    var steps: [Instruction] = []
    var wildRanks: [Rank] = []
    var wildCards: [Card] = []
    var wildCustoms: [String] = []
    var winningHands: [CardBunch] = []
    var variants: [Variant] = []
    
    func hasWilds() -> Bool {
        return !wildCards.isEmpty || !wildRanks.isEmpty || !wildCustoms.isEmpty
    }
    
    func hasWinningHands() -> Bool {
        return !winningHands.isEmpty
    }
    
    func hasVariants() -> Bool {
        return !variants.isEmpty
    }
    
    func getAllWildCards() -> [CardBunch] {
        let rankBunches: [CardBunch] = wildRanks.map({ CardBunch(description: $0.descriptionPlural, cards: $0.allSuits) })
        let cardBunches: [CardBunch] = wildCards.map({ CardBunch(description: $0.description, cards: [$0]) })
        let customBunches: [CardBunch] = wildCustoms.map({ CardBunch(description: $0, cards: []) })
        return rankBunches + cardBunches + customBunches
    }
}

struct Instruction: Hashable, Codable {
    var description: String
    var subtext: String?
    var offerQuickReference: Bool?
}

enum InstructionType: Int, Codable {
    case generic
    case ante_pay
}

enum WinConditionType: Int, Codable {
    case basic_poker
    case custom
}

struct Variant: Hashable, Codable {
    var name: String
    var description: String
}
