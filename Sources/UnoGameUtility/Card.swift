//
//  Card.swift
//  UNO
//
//  Created by FEIFAN YANG on 3/27/24.
//

import Foundation

public struct Card: CustomDebugStringConvertible & Identifiable & Comparable & Equatable {
    public var id: String
    
    let content: Content
    let color: Color
    
    var isFaceUp: Bool = false
    
    var isWild: Bool {
        color == .none
    }
    
    var isFunctional: Bool {
        isWild || content == .skip || content == .reverse || content == .drawTwo
    }
    
    func similar(to card: Card?) -> Bool {
        content == card?.content || color == card?.color
    }
    
    func same(as card: Card?) -> Bool {
        content == card?.content && color == card?.color
    }
    
    func canBeat(_ card: Card?) -> Bool {
        if let card {
            return isWild || similar(to: card)
        }
        return true
    }
    
    enum Content: Int, CaseIterable, CustomStringConvertible {
        var description: String {
            switch self {
            case .drawTwo: return "+2"
            case .skip: return "skip"
            case .reverse: return "reverse"
            case .wild: return "wild"
            case .drawFour: return "+4"
            default: return String(rawValue)
            }
        }
        
        case zero, one, two, three, four, five, six, seven, eight, nine
        case drawTwo, skip, reverse, wild, drawFour
    }
    
    enum Color: Int, CaseIterable {
        case red
        case blue
        case yellow
        case green
        case none
    }
    
    public static func < (lhs: Card, rhs: Card) -> Bool {
        if lhs.color == rhs.color {
            return lhs.content.rawValue < rhs.content.rawValue
        } else {
            return lhs.color.rawValue < rhs.color.rawValue
        }
    }
    
    public var debugDescription: String {
        "<\(String(describing: color)) \(content)>"
    }
}
