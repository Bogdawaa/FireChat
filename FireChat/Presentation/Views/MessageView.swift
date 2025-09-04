//
//  MessaveView.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 15.08.2025.
//

import SwiftUI

struct MessageView: View {
    
    private let message: ChatMessage
    private var textColor: Color = .white
    
    var cornerRadius: CGFloat
    var isSender: Bool = false
    
    init(message: ChatMessage, cornerRadius: CGFloat = 8, isSender: Bool = false) {
        self.message = message
        self.cornerRadius = cornerRadius
        self.isSender = isSender
    }

    var body: some View {
        VStack(alignment: .trailing) {
            Text(message.text)
                .padding(.horizontal)
                .padding(.vertical, 6)
                .multilineTextAlignment(.leading)
                .foregroundStyle(textColor)
                .background(.appCard)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: cornerRadius,
                        bottomLeadingRadius: isSender ? cornerRadius : 0,
                        bottomTrailingRadius: isSender ? 0 : cornerRadius,
                        topTrailingRadius: cornerRadius
                    )
                )
                Text(message.timestamp.formatted(date: .omitted, time: .shortened))
                    .foregroundStyle(.gray.opacity(0.7))
                    .font(.system(size: 10))
                    .font(.callout)
        }
        .frame(maxWidth: .infinity, alignment: isSender ? .trailing : .leading)
    }
}

#Preview {
    MessageView(
        message: ChatMessage.mock,
        cornerRadius: 8,
        isSender: true
    )
}
