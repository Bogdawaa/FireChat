//
//  ChatView.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 15.08.2025.
//

import SwiftUI

struct ChatView: View {
    let chatId: String
    @StateObject private var viewModel: ChatViewModel
    
    init(chatId: String) {
        self.chatId = chatId
        self._viewModel = StateObject(wrappedValue: ChatView.makeViewModel(chatId: chatId))
    }
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.messages) { message in
                        let isSender = message.sender.id == viewModel.currentUser.id
                        HStack {
                            if isSender { Spacer() }
                            MessageView(message: message, isSender: isSender)
                            if !isSender { Spacer() }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            
            HStack {
                TextField("Message", text: $viewModel.newMessageText)
                    .textFieldStyle(.roundedBorder)
                
                Button("Send") {
                    Task { await viewModel.sendMessage() }
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.newMessageText.isEmpty)
            }
            .padding()
        }
        .navigationTitle("Chat")
    }
    
    private static func makeViewModel(chatId: String) -> ChatViewModel {
        let repository = FirebaseMessagesRepository()
        let sendUseCase = SendMessageUseCaseImpl(repository: repository)
        let observeUseCase = ObserveMessagesUseCaseImpl(repository: repository)
        return ChatViewModel(
            chatId: chatId,
            sendMessageUseCase: sendUseCase,
            observeMessagesUseCase: observeUseCase
        )
    }
}

#Preview {
    ChatView(chatId: "default_chat_id")
}
