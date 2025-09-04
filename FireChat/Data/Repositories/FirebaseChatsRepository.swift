//
//  FirebaseChatsRepository.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 18.08.2025.
//

import FirebaseFirestore

final class FirebaseChatsRepository: ChatsRepository {
    private let firestore = Firestore.firestore()

    func create(_ chat: ChatListItem) async throws {
        let dto = ChatDTO(from: chat)
        try await firestore.collection("chats").addDocument(data: dto.toDictionary())
    }
    
    func observeChats(for userId: String) -> AsyncThrowingStream<[ChatListItem], any Error> {
        AsyncThrowingStream { continuation in
            let listener = firestore.collection("chats")
                .whereField("participants", arrayContains: userId)
                .order(by: "lastMessageTime")
                .addSnapshotListener { snapshot, error in
                    if let error = error {
                        continuation.finish(throwing: error)
                        return
                    }
                    
                    let chats = snapshot?.documents
                        .compactMap { try? $0.data(as: ChatDTO.self) }
                        .map { $0.toDomain() } ?? []
                    
                    print(chats)
                    continuation.yield(chats)
                }
            
            continuation.onTermination = { _ in
                listener.remove()
            }
        }
    }
}
