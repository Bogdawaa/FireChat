//
//  Message.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 15.08.2025.
//

import Foundation

struct ChatMessage: Identifiable {
    let id: String
    let text: String
    let sender: User
    let timestamp: Date
    let chatId: String
    let isRead: Bool
}

extension ChatMessage {
    static var mock = ChatMessage(
        id: "1",
        text: "Hello",
        sender: User.mock,
        timestamp: Date(),
        chatId: "1",
        isRead: false
    )
}
