//
//  Client.swift
//  UNO
//
//  Created by FEIFAN YANG on 4/10/24.
//

import Foundation
import Starscream

public class Client: Hashable & Equatable {
    var name: String
    var socket: WebSocket
    var server: Server?
    var room: Room?
    var player: Player?
    var isHost: Bool
    
    var isReady: Bool { player?.isReady ?? false}
    

    init(name: String, server: Server) {
        self.name = name
        self.server = server
        isHost = false
        socket = WebSocket(request: URLRequest(url: URL(string: "ws://uno.websocket.org")!))
        socket.onEvent = { event in
            switch event {
            case .connected(let headers):
                print("connected: \(headers)")
            case .disconnected(let reason, let code):
                self.server = nil
                print("disconnected: \(reason) with code: \(code)")
            case .binary(let data):
                let message = try? JSONDecoder().decode(Message.self, from: data)
            default:
                break
            }
        }
        socket.connect()
    }
    
    public func writeText(_ text: String) {
        socket.write(string: text)
    }
    
    public func writeMessage(_ message: Message) {
        do {
            let data = try JSONEncoder().encode(message)
            socket.write(data: data)
        } catch {
            print("Failed to encode: \(error)")
        }
    }
    
    public func disconnect() {
        writeMessage(Message(type: .disconnect, content: "\(name) disconnected", sender: name))
        socket.disconnect(closeCode: 100)
    }
    
    // MARK: - Protocol functions

    public static func == (lhs: Client, rhs: Client) -> Bool {
        lhs.name == rhs.name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
