//
//  ChatListViewModel.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 19.08.2025.
//

import SwiftUI

@MainActor
final class ChatListViewModel: ObservableObject {
    @Published var chats: [ChatListItem] = []
    @Published var errorMessage: String?
    
    private var observeChatsUseCase: ObserveChatsUseCase
    private var observationTask: Task<Void, Never>?
    private(set) var currentUser = User(id: "1", name: "Bogdan", email: "", profileURL: nil) // Mock user

    init(observeChatsUseCase: ObserveChatsUseCase) {
        self.observeChatsUseCase = observeChatsUseCase
        startObserving()
    }
    
    private func startObserving() {
        observationTask = Task {
            do {
                for try await chats in observeChatsUseCase.execute(userId: currentUser.id) {
                    print("ViewModel received chats:", chats.count)
                    self.chats = chats
                }
            } catch {
                print("Observation error:", error.localizedDescription)
            }
        }
    }
}
