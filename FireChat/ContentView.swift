//
//  ContentView.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 15.08.2025.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
//            ChatView()
            ChatListView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
