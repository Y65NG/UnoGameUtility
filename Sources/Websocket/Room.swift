//
//  Room.swift
//  UNO
//
//  Created by FEIFAN YANG on 4/10/24.
//

import Foundation

public class Room {
    var name: String
    var players: Set<Player>

    var numberOfReadyMember: Int {
        var result = 0
        players.forEach { result += $0.isReady ? 1 : 0 }
        return result
    }

    static let lobby = Room(name: "Lobby")

    init(name: String, members: Set<Player>? = nil) {
        self.name = name
        self.players = members ?? []
    }

    func addPlayer(_ player: Player) throws {
        if players.contains(player) {
            throw ServerError.clientAlreadyExists(name: player.name)
        }

        if players.count == 0 {
//            client.isHost = true
        }
        players.insert(player)
    }
    
    func addPlayer(from client: Client) throws {
        
    }
}
