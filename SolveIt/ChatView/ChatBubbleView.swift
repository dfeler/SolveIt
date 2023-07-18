//
//  ChatBubbleView.swift
//  SolveIt
//
//  Created by Daniel Feler on 3/29/23.
//

import SwiftUI

struct ChatBubbleView: View {
    @Binding var showChatScreen: Bool

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        showChatScreen.toggle()
                    }
                }) {
                    Image(systemName: "message.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 8)
                }
                .padding(.bottom, 65)
                .padding(.trailing)
            }
        }
    }
}
