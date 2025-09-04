//
//  MessageDTO.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 15.08.2025.
//

import FirebaseFirestore

struct MessageDTO: Codable {
    @DocumentID var id: String?
    let text: String
    let senderId: String
    let senderName: String
    let timestamp: Timestamp
    let chatId: String
    let isRead: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case senderId = "sender_id"
        case senderName = "sender_name"
        case timestamp
        case chatId = "chat_id"
        case isRead = "is_read"
    }
    
    // Конвертация из Domain
    init(from domain: ChatMessage) {
        self.text = domain.text
        self.senderId = domain.sender.id
        self.senderName = domain.sender.name
        self.timestamp = Timestamp(date: domain.timestamp)
        self.chatId = domain.chatId
        self.isRead = domain.isRead
    }
    
    // Конвертация в Domain
    func toDomain() -> ChatMessage {
        ChatMessage(
            id: id ?? UUID().uuidString,
            text: text,
            sender: User(id: senderId, name: senderName, email: "", profileURL: nil),
            timestamp: timestamp.dateValue(),
            chatId: chatId,
            isRead: isRead
        )
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "text": text,
            "sender_id": senderId,
            "sender_name": senderName,
            "timestamp": timestamp,
            "chat_id": chatId,
            "is_read": isRead
        ]
    }
}
