//
//  Game.swift
//  Poker Face
//
//  Created by Alex Baratti on 12/14/22.
//

import Foundation

struct Game: Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
    var steps: [Instruction] = []
    var wildranks: [Rank] = []
    var wildcards: [Card] = []
    
    func hasWilds() -> Bool {
        return !wildcards.isEmpty || !wildranks.isEmpty
    }
}

struct Instruction: Hashable {
    var description: String
    var cards: [Card] = []
}
