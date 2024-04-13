//
//  Room.swift
//  UNO
//
//  Created by FEIFAN YANG on 4/10/24.
//

import Foundation

public class Room {
    public let server: Server
    public var name: String
    public var clients: Set<Client>
    

    public var numberOfReadyMember: Int {
        var result = 0
        clients.forEach { result += $0.isReady ? 1 : 0 }
        return result
    }


    public init(name: String, server: Server, members: Set<Client> = []) {
        self.name = name
        self.server = server
        self.clients = members
    }

    public func addClient(_ client: Client) throws {
        if clients.contains(client) {
            throw ServerError.clientAlreadyExists(name: client.name)
        }

        if clients.count == 0 {
            client.isHost = true
        }
        clients.insert(client)
    }

}
