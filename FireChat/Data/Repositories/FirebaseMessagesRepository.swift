//
//  FirebaseMessagesRepository.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 15.08.2025.
//

import FirebaseFirestore

final class FirebaseMessagesRepository: MessagesRepository {
    private let firestore = Firestore.firestore()
    
    func send(_ message: ChatMessage) async throws {
        let dto = MessageDTO(from: message)
        try await firestore.collection("messages").addDocument(data: dto.toDictionary())
    }
    
    func observeMessages(for chatId: String) -> AsyncThrowingStream<[ChatMessage], any Error> {
        AsyncThrowingStream { continuation in
            let listener = firestore.collection("messages")
                .whereField("chat_id", isEqualTo: chatId)
                .order(by: "timestamp")
                .addSnapshotListener { snapshot, error in
                    if let error = error {
                        continuation.finish(throwing: error)
                        return
                    }
                    
                    let messages = snapshot?.documents
                        .compactMap { try? $0.data(as: MessageDTO.self) }
                        .map { $0.toDomain() } ?? []
                    
                    print(messages)
                    continuation.yield(messages)
                }
            
            continuation.onTermination = { _ in
                listener.remove()
            }
        }
    }
    
    func markAsRead(messageId: String) async throws {
        try await Firestore.firestore()
            .collection("messages")
            .document(messageId)
            .updateData(["is_read": true])
    }
}
