//
//  CoordinateView.swift
//  SolveIt
//
//  Created by Daniel Feler on 1/7/23.
//

import SwiftUI
import AVKit

struct VideoView: View {
    
    let videoUrl = Bundle.main.url(forResource: "solveitIntro", withExtension: "mp4")!
    var body: some View {
        ZStack {
            Color(.black)
            VideoBackground(videoUrl: videoUrl)
        }
    }
}

struct CoordinateView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}

struct VideoBackground: UIViewRepresentable {
    let videoUrl: URL

    func makeUIView(context: UIViewRepresentableContext<VideoBackground>) -> UIView {
        let view = UIView(frame: .zero)

        let player = AVPlayer(url: videoUrl)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)

        player.play()
        player.actionAtItemEnd = .none

        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            player.seek(to: CMTime.zero)
            player.play()
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoBackground>) {
    
    }
}

