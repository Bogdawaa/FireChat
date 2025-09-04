//
//  ChatListView.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 15.08.2025.
//

import SwiftUI

struct ChatListView: View {
    @StateObject private var viewModel: ChatListViewModel
    @State private var path = NavigationPath()
    
    init() {
        let repository = FirebaseChatsRepository()
        let observeUseCase = ObserveChatsUseCaseImpl(repository: repository)
        
        self._viewModel = StateObject(
            wrappedValue: ChatListViewModel(observeChatsUseCase: observeUseCase)
        )
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.chats) { chat in
                        ChatListItemView(chat: chat)
                            .onTapGesture {
                                path.append(chat)
                            }
                    }
                }
            }
            .navigationDestination(for: ChatListItem.self) { chat in
                ChatView(chatId: chat.id)
            }
        }
    }
}

struct ChatListItemView: View {
    private let chat: ChatListItem
    
    init(chat: ChatListItem) {
        self.chat = chat
    }
    
    var body: some View {
        HStack {
            Image(.profileMock)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 40)
            VStack(alignment: .leading) {
                Text("Chat name")
                    .font(.headline)
                Text(chat.lastMessage)
                    .font(.subheadline)
                    .lineLimit(1)
                Rectangle()
                    .frame(height: 1)
                    .background(Color.gray)
            }
        }
    }
}

//#Preview {
//    ChatListView()
//}
