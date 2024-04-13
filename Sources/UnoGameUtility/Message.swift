//
//  File.swift
//  
//
//  Created by FEIFAN YANG on 4/12/24.
//

import Foundation

public struct Message: Codable {
    let type: MessageType
    let content: String
    let sender: String
    
    enum MessageType: Hashable & Codable {
        case message
    }
}
