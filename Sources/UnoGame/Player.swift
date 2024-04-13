//
//  Player.swift
//  UNO
//
//  Created by FEIFAN YANG on 3/27/24.
//

import Foundation

public class Player: Hashable {
    let name: String
    var cards = [Card]()
    var isReady = false
    var status: State = .pending
    
    init(name: String) {
        self.name = name
    }

    func draw(_ numberOfCards: Int, from deck: inout Deck) throws {
        var dealtCards: [Card]
        dealtCards = try deck.deal(numberOfCards)

        cards.append(contentsOf: dealtCards)
        cards.sort()
    }

    func use(_ card: Card, toBeat lastCard: Card) throws {
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

    enum State {
        case pending
        case action(Action)
        case message(String)

        enum Action {
            case drawCards
            case useCards
            case newTurn
        }
    }
}

extension [Card] {
    mutating func removeFirst(where cmp: (Card) -> Bool) -> Card? {
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
