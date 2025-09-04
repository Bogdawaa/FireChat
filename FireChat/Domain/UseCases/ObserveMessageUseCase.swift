//
//  ObserveMessageUseCase.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 15.08.2025.
//

protocol ObserveMessagesUseCase {
    func execute(chatId: String) -> AsyncThrowingStream<[ChatMessage], Error>
}

final class ObserveMessagesUseCaseImpl: ObserveMessagesUseCase {
    private let repository: MessagesRepository
    
    init(repository: MessagesRepository) {
        self.repository = repository
    }
    
    func execute(chatId: String) -> AsyncThrowingStream<[ChatMessage], Error> {
        repository.observeMessages(for: chatId)
    }
}
