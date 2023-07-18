//
//  InitialViewModel.swift
//  SolveIt
//
//  Created by Daniel Feler on 2/15/23.
//

import SwiftUI

class InitialViewModel: ObservableObject {
    @Published var isShowing = false
    @Published var hasAppeared = false

    func startAnimation() {
        if !hasAppeared {
            withAnimation(Animation.easeInOut(duration: 1).delay(0.5)) {
                isShowing.toggle()
            }
            hasAppeared = true
        }
    }
}
