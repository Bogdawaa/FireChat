//
//  SendMessage.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 15.08.2025.
//

protocol SendMessageUseCase {
    func execute(_ message: ChatMessage) async throws
}

final class SendMessageUseCaseImpl: SendMessageUseCase {
    private let repository: MessagesRepository
    
    init(repository: MessagesRepository) {
        self.repository = repository
    }
    
    func execute(_ message: ChatMessage) async throws {
        try await repository.send(message)
    }
}
