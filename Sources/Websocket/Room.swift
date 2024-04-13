//
//  Room.swift
//  UNO
//
//  Created by FEIFAN YANG on 4/10/24.
//

import Foundation

class Room {
    var name: String
    var clients: Set<Client>

    var numberOfReadyMember: Int {
        var result = 0
        clients.forEach { result += $0.isReady ? 1 : 0 }
        return result
    }

    static let lobby = Room(name: "Lobby")

    init(name: String, members: Set<Client>? = nil) {
        self.name = name
        self.clients = members ?? []
    }

    func addClient(_ client: Client) throws {
        if clients.contains(client) {
            throw ServerError.clientAlreadyExists(name: client.name)
        }

        if clients.count == 0 {
            client.isHost = true
        }
        clients.insert(client)
    }
}
