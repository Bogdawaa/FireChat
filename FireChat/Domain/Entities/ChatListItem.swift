//
//  ChatListItem.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 18.08.2025.
//

import Foundation

struct ChatListItem: Identifiable, Hashable {
    let id: String
    let participants: [String]
    let lastMessage: String
    let lastMessageTime: Date
    let createdAt: Date
}
