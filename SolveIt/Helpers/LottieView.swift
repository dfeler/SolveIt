//
//  LottieView.swift
//  SolveIt
//
//  Created by Daniel Feler on 12/26/22.
//

import SwiftUI
import UIKit
import Lottie

struct Lottielmage: UIViewRepresentable {
    let animationName: String
    let loopMode: LottieLoopMode
    let pauseTime: Double?
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        let animationView = AnimationView()
        let animation = Animation.named(animationName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        
        if pauseTime != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + pauseTime!) {
                animationView.pause()
            }
        }
        
        animationView.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
        return view
    }
    func updateUIView(_ uiview: UIViewType, context: Context) { }
}
