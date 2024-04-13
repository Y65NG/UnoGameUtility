//
//  Errors.swift
//  UNO
//
//  Created by FEIFAN YANG on 3/27/24.
//

import Foundation

public enum GameLogicError: Error {
    case indexOutOfBound(bound: Int)
    case noSuchElement(element: Sendable)
    case cannotBeatLastPlayer
}

public enum ServerError: Error {
    case roomNotFound(name: String)
    case clientAlreadyExists(name: String)
}
