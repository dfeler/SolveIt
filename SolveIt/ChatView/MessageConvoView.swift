//
//  MessageConvoView.swift
//  SolveIt
//
//  Created by Daniel Feler on 3/29/23.
//

import SwiftUI

struct MessageConvoView: View {
    let message: Message

    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            if message.sender == "user" {
                Spacer()
            }

            Text(message.text)
                .padding()
                .foregroundColor(Color.white)
                .background(message.sender == "user" ? Color.blue : Color.gray)
                .cornerRadius(16)

            if message.sender == "copilot" {
                Spacer()
            }
        }
    }
}
