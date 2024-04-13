//
//  Card.swift
//  UNO
//
//  Created by FEIFAN YANG on 3/27/24.
//

import Foundation

public struct Card: CustomDebugStringConvertible & Identifiable & Comparable & Equatable {
    public var id: String
    
    public let content: Content
    public let color: Color
    
    public var isFaceUp: Bool = false
    
    public var isWild: Bool {
        color == .none
    }
    
    public var isFunctional: Bool {
        isWild || content == .skip || content == .reverse || content == .drawTwo
    }
    
    public func similar(to card: Card?) -> Bool {
        content == card?.content || color == card?.color
    }
    
    public func same(as card: Card?) -> Bool {
        content == card?.content && color == card?.color
    }
    
    public func canBeat(_ card: Card?) -> Bool {
        if let card {
            return isWild || similar(to: card)
        }
        return true
    }
    
    public enum Content: Int, CaseIterable, CustomStringConvertible {
        public var description: String {
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
    
    public enum Color: Int, CaseIterable {
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
