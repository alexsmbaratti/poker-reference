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
