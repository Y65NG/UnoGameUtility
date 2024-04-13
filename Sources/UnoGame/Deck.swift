//
//  Deck.swift
//  UNO
//
//  Created by FEIFAN YANG on 3/27/24.
//

import Foundation

public struct Deck {
    public var cards = [Card]()
    
    public init() {
        var idNumber = 0
        for color in Card.Color.allCases {
            for content in Card.Content.allCases {
                if color != .none, content != Card.Content.wild, content != Card.Content.drawFour {
                    cards.append(Card(id: "\(idNumber)a", content: content, color: color))
                    cards.append(Card(id: "\(idNumber)b", content: content, color: color))
                    idNumber += 1
                }
            }
        }
        let idLetters = ["a", "b", "c", "d"]
        for idLetter in idLetters {
            cards.append(Card(id: "\(idNumber)\(idLetter)", content: Card.Content.wild, color: Card.Color.none))
            cards.append(Card(id: "\(idNumber + 1)\(idLetter)", content: Card.Content.drawFour, color: Card.Color.none))
        }
    }
    
    public var count: Int {
        cards.count
    }
    
    public mutating func shuffle() {
        cards.shuffle()
    }
    
    public mutating func deal(_ numberOfCards: Int) throws -> [Card] {
        if numberOfCards > count {
            throw GameLogicError.indexOutOfBound(bound: count)
        }
        var dealtCards = [Card]()
        for _ in 0 ..< numberOfCards {
            var dealtCard = cards.removeLast()
            dealtCard.isFaceUp.toggle()
            dealtCards.append(dealtCard)
        }
        return dealtCards
    }
}
