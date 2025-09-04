//
//  ChatsDTO.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 18.08.2025.
//

import FirebaseFirestore

struct ChatDTO: Codable {
    @DocumentID var id: String?
    let participants: [String]
    let lastMessage: String
    let lastMessageTime: Timestamp
    let createdAt: Timestamp
    
    // Конвертация из Domain
    init(from domain: ChatListItem) {
        self.participants = domain.participants
        self.lastMessage = domain.lastMessage
        self.lastMessageTime = Timestamp(date: domain.lastMessageTime)
        self.createdAt = Timestamp(date: Date())
    }
    
    // Конвертация в Domain
    func toDomain() -> ChatListItem {
        ChatListItem(
            id: id ?? UUID().uuidString,
            participants: participants,
            lastMessage: lastMessage,
            lastMessageTime: lastMessageTime.dateValue(),
            createdAt: createdAt.dateValue()
        )
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "participants": participants,
            "lastMessage": lastMessage,
            "lastMessageTime": lastMessageTime,
            "createdAt": createdAt
        ]
    }
}
