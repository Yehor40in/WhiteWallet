////
////  VideoUIView.swift
////  WhiteWallet
////
////  Created by Yehor Sorochin on 06.07.24.
////
//
//import SwiftUI
//import AVKit
//
//class VideoUIView: UIView {
//    private let playerLayer = AVPlayerLayer()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        if let fileURL = Bundle.main.url(forResource: "", withExtension: "") {
//            let player = AVPlayer(url: fileURL)
//            player.actionAtItemEnd = .none
//            player.play()
//            
//            playerLayer.player = player
//            playerLayer.videoGravity = .resizeAspectFill
//            
//            NotificationCenter.default.addObserver(self,
//                                                   selector: #selector(playerItemDidReachEnd(notification:)),
//                                                   name: .AVPlayerItemDidPlayToEndTime,
//                                                   object: player.currentItem)
//
//            layer.addSublayer(playerLayer)
//        }
//    }
//    
//    @objc func playerItemDidReachEnd(notification: Notification) {
//        if let playerItem = notification.object as? AVPlayerItem {
//            playerItem.seek(to: .zero, completionHandler: nil)
//        }
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        playerLayer.frame = bounds
//    }
//}
//
//#Preview {
//    VideoUIView()
//}
