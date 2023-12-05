//
//  CardUtilsTests.swift
//  Poker FaceTests
//
//  Created by Alex Baratti on 12/14/22.
//

import XCTest

final class CardUtilsTests: XCTestCase {
    
    func testAllOfSameSuit() throws {
        XCTAssertFalse(CardUtils.allOfSameSuit(cards: [Card(rank: .ace, suit: .diamond), Card(rank: .king, suit: .spade), Card(rank: .queen, suit: .heart), Card(rank: .jack, suit: .club), Card(rank: .ten, suit: .heart)]))
        XCTAssertTrue(CardUtils.allOfSameSuit(cards: [Card(rank: .ace, suit: .heart), Card(rank: .king, suit: .heart), Card(rank: .queen, suit: .heart), Card(rank: .jack, suit: .heart), Card(rank: .ten, suit: .heart)]))
        XCTAssertTrue(CardUtils.allOfSameSuit(cards: [Card(rank: .ace, suit: .diamond), Card(rank: .king, suit: .diamond), Card(rank: .queen, suit: .diamond), Card(rank: .jack, suit: .diamond), Card(rank: .ten, suit: .diamond)]))
        XCTAssertTrue(CardUtils.allOfSameSuit(cards: [Card(rank: .ace, suit: .club), Card(rank: .king, suit: .club), Card(rank: .queen, suit: .club), Card(rank: .jack, suit: .club), Card(rank: .ten, suit: .club)]))
        XCTAssertTrue(CardUtils.allOfSameSuit(cards: [Card(rank: .ace, suit: .spade), Card(rank: .king, suit: .spade), Card(rank: .queen, suit: .spade), Card(rank: .jack, suit: .spade), Card(rank: .ten, suit: .spade)]))
    }
    
    func testContainsRank() throws {
        XCTAssertTrue(CardUtils.containsRank(rank: .king, cards: [Card(rank: .ace, suit: .heart), Card(rank: .king, suit: .heart), Card(rank: .queen, suit: .heart), Card(rank: .jack, suit: .heart), Card(rank: .ten, suit: .heart)]))
        XCTAssertFalse(CardUtils.containsRank(rank: .king, cards: [Card(rank: .ace, suit: .heart), Card(rank: .two, suit: .heart), Card(rank: .three, suit: .heart), Card(rank: .four, suit: .heart), Card(rank: .five, suit: .heart)]))
    }
    
    func testContainsRanks() throws {
        XCTAssertTrue(CardUtils.containsRanks(ranks: [.ace, .king], cards: [Card(rank: .ace, suit: .heart), Card(rank: .king, suit: .heart), Card(rank: .queen, suit: .heart), Card(rank: .jack, suit: .heart), Card(rank: .ten, suit: .heart)]))
        XCTAssertFalse(CardUtils.containsRanks(ranks: [.ace, .two], cards: [Card(rank: .ace, suit: .heart), Card(rank: .king, suit: .heart), Card(rank: .queen, suit: .heart), Card(rank: .jack, suit: .heart), Card(rank: .ten, suit: .heart)]))
    }
    
    func testIsFullHand() throws {
        XCTAssertTrue(CardUtils.containsRank(rank: .king, cards: [Card(rank: .ace, suit: .heart), Card(rank: .king, suit: .heart), Card(rank: .queen, suit: .heart), Card(rank: .jack, suit: .heart), Card(rank: .ten, suit: .heart)]))
    }
    
    func testIsInSequence() throws {
        XCTAssertTrue(CardUtils.isInSequence(cards: [Card(rank: .queen, suit: .heart), Card(rank: .jack, suit: .heart), Card(rank: .ten, suit: .heart), Card(rank: .nine, suit: .heart), Card(rank: .eight, suit: .heart)]))
        XCTAssertFalse(CardUtils.isInSequence(cards: [Card(rank: .queen, suit: .heart), Card(rank: .jack, suit: .heart), Card(rank: .ten, suit: .heart), Card(rank: .eight, suit: .heart), Card(rank: .nine, suit: .heart)]), "Test failed for sequential cards out of order")
    }
    
    func testGetHand() throws {
        XCTAssertEqual(CardUtils.getHand(cards: [Card(rank: .ace, suit: .heart), Card(rank: .king, suit: .heart), Card(rank: .queen, suit: .heart), Card(rank: .jack, suit: .heart), Card(rank: .ten, suit: .heart)]), .royal_flush)
        XCTAssertEqual(CardUtils.getHand(cards: [Card(rank: .nine, suit: .spade), Card(rank: .eight, suit: .spade), Card(rank: .seven, suit: .spade), Card(rank: .six, suit: .spade), Card(rank: .five, suit: .spade)]), .straight_flush)
    }
    
    func testExampleHands() throws {
        XCTAssertEqual(CardUtils.getHand(cards: Hand.royal_flush.exampleHand), .royal_flush)
    }
}
