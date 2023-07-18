//
//  TypeWriterView.swift
//  HomeworkHelper
//
//  Created by Daniel Feler on 12/8/22.
//

import SwiftUI

struct Typewriter: View {
    let text: String
    @State private var currentIndex = 0
    var speed: Double
    var body: some View {
        ScrollView {
            Text(String(text.prefix(currentIndex)))
                .padding()
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { timer in
                        currentIndex += 1
                        if currentIndex > text.count {
                            timer.invalidate()
                        }
                    }
                }
        }
    }
}

