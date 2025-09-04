//
//  ChatsRepository.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 18.08.2025.
//

protocol ChatsRepository {
    func create(_ chat: ChatListItem) async throws
    func observeChats(for userId: String) -> AsyncThrowingStream<[ChatListItem], Error>
}
