//
//  Card.swift
//  Poker Face
//
//  Created by Alex Baratti on 12/11/22.
//

import Foundation
import SwiftUI

struct Card: CustomStringConvertible {
    var rank: Rank
    var suit: Suit
    
    var description: String {
        return "\(rank) of \(suit)"
    }
}

enum Suit: String {
    case club = "Clubs"
    case diamond = "Diamonds"
    case heart = "Hearts"
    case spade = "Spades"
    
    var symbol: String {
        switch self {
        case .club:
            return "suit.club.fill"
        case .diamond:
            return "suit.diamond.fill"
        case .heart:
            return "suit.heart.fill"
        case .spade:
            return "suit.spade.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .club:
            return .black
        case .diamond:
            return .red
        case .heart:
            return .red
        case .spade:
            return .black
        }
    }
}

enum Rank: Int, CaseIterable {
    case ace = 1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
    
    var symbol: String {
        switch self {
        case .ace:
            return "A"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .ten:
            return "10"
        case .jack:
            return "J"
        case .queen:
            return "Q"
        case .king:
            return "K"
        }
    }
}
