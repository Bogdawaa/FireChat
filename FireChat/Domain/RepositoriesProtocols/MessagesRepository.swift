//
//  SendMessageRepository.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 15.08.2025.
//

protocol MessagesRepository {
    func send(_ message: ChatMessage) async throws
    func observeMessages(for chatId: String) -> AsyncThrowingStream<[ChatMessage], Error>
    func markAsRead(messageId: String) async throws
}
