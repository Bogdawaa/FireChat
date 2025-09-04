//
//  ChatViewModel.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 15.08.2025.
//

import SwiftUI

@MainActor
final class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var newMessageText = ""
    @Published var errorMessage: String?
    
    private let sendMessageUseCase: SendMessageUseCase
    private let observeMessagesUseCase: ObserveMessagesUseCase
    private let chatId: String
    private var observationTask: Task<Void, Never>?
    
    private(set) var currentUser = User(id: "1", name: "Bogdan", email: "", profileURL: nil) // Mock user
        
    init(
        chatId: String,
        sendMessageUseCase: SendMessageUseCase,
        observeMessagesUseCase: ObserveMessagesUseCase
    ) {
        self.chatId = chatId
        self.sendMessageUseCase = sendMessageUseCase
        self.observeMessagesUseCase = observeMessagesUseCase
        
        startObserving()
    }
    
    func sendMessage() async {
        let message = ChatMessage(
            id: UUID().uuidString,
            text: newMessageText,
            sender: currentUser,
            timestamp: Date(),
            chatId: chatId,
            isRead: false
        )
        
        do {
            try await sendMessageUseCase.execute(message)
            newMessageText = ""
        } catch {
            print("Send message error:", error.localizedDescription)
        }
    }
    
    private func startObserving() {
        observationTask = Task {
            do {
                for try await messages in observeMessagesUseCase.execute(chatId: chatId) {
                    print("ViewModel received messages:", messages.count)
                    self.messages = messages
                }
            } catch {
                print("Observation error:", error.localizedDescription)
            }
        }
    }
    
    // MARK: - deinit
    deinit {
        observationTask?.cancel()
    }
}
