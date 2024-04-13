//
//  Message.swift
//  UNO
//
//  Created by FEIFAN YANG on 4/11/24.
//

import Foundation

public struct Message: Codable & Equatable {
    let type: MessageType
    let content: String
    let sender: String
    
    enum MessageType: Hashable & Codable {
        case message
        case disconnect
    }
}
