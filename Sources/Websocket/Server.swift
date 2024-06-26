//
//  Server.swift
//  UNO
//
//  Created by FEIFAN YANG on 4/10/24.
//

import Foundation

public class Server {
    public var rooms: [Room] = []

    public init() {
        rooms = [Room(name: "Lobby", server: self)]
    }

    public func addClient(_ client: Client, to roomName: String) throws {
        if let room = rooms.filter({ $0.name == roomName }).first {
            try room.addClient(client)
        } else {
            throw ServerError.roomNotFound(name: roomName)
        }
    }
}
