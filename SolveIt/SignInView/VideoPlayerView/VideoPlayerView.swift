//
//  VideoPlayerView.swift
//  SolveIt
//
//  Created by Daniel Feler on 2/15/23.
//

import SwiftUI
import AVFoundation

struct PlayerView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }
    
    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(frame: .zero)
    }
}

struct LoopingPlayerView: View {
    let player: AVQueuePlayer
    
    var body: some View {
        ZStack {
            PlayerView()
        }.onAppear {
            self.player.play()
        }.onDisappear {
            self.player.pause()
        }
    }
}

class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    let player: AVQueuePlayer
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        
        let fileUrl = Bundle.main.url(forResource: "solveitIntro", withExtension: "mp4")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        player = AVQueuePlayer()
        super.init(frame: frame)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
        } catch {
            print("Error setting audio session category: \(error)")
        }
        
        player.play()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
