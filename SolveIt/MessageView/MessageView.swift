//
//  MessagesView.swift
//  SolveIt
//
//  Created by Daniel Feler on 2/15/23.
//

import SwiftUI

struct MessageView: View {
    var body: some View {
        NavigationView {
            VStack {
                Lottielmage(animationName: "bell", loopMode: .playOnce, pauseTime: nil)
                    .frame(width: 100, height: 100)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Messages")
                        .font(.system(size: 28,
                                      weight: .bold,
                                      design: .default))
                        .padding(.bottom, 10)
                }
            }
        }
    }
}
