//
//  Player.swift
//  UNO
//
//  Created by FEIFAN YANG on 3/27/24.
//

import Foundation

public class Player: Hashable {
    public let name: String
    public var cards = [Card]()
    public var isReady = false
    public var status: State = .pending
    
    public init(name: String) {
        self.name = name
    }

    public func draw(_ numberOfCards: Int, from deck: inout Deck) throws {
        var dealtCards: [Card]
        dealtCards = try deck.deal(numberOfCards)

        cards.append(contentsOf: dealtCards)
        cards.sort()
    }

    public func use(_ card: Card, toBeat lastCard: Card) throws {
        if !cards.contains(card) {
            throw GameLogicError.noSuchElement(element: card)
        }
        if !card.canBeat(lastCard) {
            throw GameLogicError.cannotBeatLastPlayer
        }
        _ = cards.removeFirst {
            card.same(as: $0)
        }
    }
    
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    public static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.name == rhs.name
    }

    public enum State {
        case pending
        case action(Action)
        case message(String)

        public enum Action {
            case drawCards
            case useCards
            case newTurn
        }
    }
}

extension [Card] {
    public mutating func removeFirst(where cmp: (Card) -> Bool) -> Card? {
        var cardToRemove: Card?
        for (idx, card) in self.enumerated() {
            if cmp(card) {
                cardToRemove = remove(at: idx)
                break
            }
        }
        return cardToRemove
    }
}
