//
//  ChatViewModel.swift
//  SolveIt
//
//  Created by Daniel Feler on 3/29/23.
//

import SwiftUI
import Combine


class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    
    init() {
        loadMessages()
    }
    
    func loadMessages() {
        guard let messages: [Message] = loadJSONData(from: "messageFeed") else {
            return
        }
        self.messages = messages
    }

}




struct Message: Codable, Identifiable {
    let id: String
    let text: String
    let sender: String
}
