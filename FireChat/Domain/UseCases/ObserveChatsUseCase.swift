//
//  ObserveChatsUseCase.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 19.08.2025.
//

protocol ObserveChatsUseCase {
    func execute(userId: String) -> AsyncThrowingStream<[ChatListItem], Error>
}

final class ObserveChatsUseCaseImpl: ObserveChatsUseCase {
    private let repository: ChatsRepository
    
    init(repository: ChatsRepository) {
        self.repository = repository
    }
    
    func execute(userId: String) -> AsyncThrowingStream<[ChatListItem], Error> {
        repository.observeChats(for: userId)
    }
}
