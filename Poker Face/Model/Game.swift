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
    var wildranks: [Rank] = []
    var wildcards: [Card] = []
    var variants: [Variant] = []
    
    func hasWilds() -> Bool {
        return !wildcards.isEmpty || !wildranks.isEmpty
    }
    
    func hasVariants() -> Bool {
        return !variants.isEmpty
    }
}

struct Instruction: Hashable, Codable {
    var description: String
    var cards: [Card] = []
}

struct Variant: Hashable, Codable {
    var name: String
    var description: String
}
