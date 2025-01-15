//
//  VideoPlayerHolderView.swift
//  LiveStream
//
//  Created by Nivedita Angadi on 04/01/25.
//

import UIKit
import Cartography
import AVKit

protocol VideoPlayerHolderViewDelegate: AnyObject {
    func videoPlayerDidStartPlaying()
}

// UIView - responsible for handling the video player related functionality - such as - play, pause, stop and clear contents.
class VideoPlayerHolderView: UIView {
    public var videoPlayerController = AVPlayerViewController()
    private var playerLooper: AVPlayerLooper!
    weak var delegate: VideoPlayerHolderViewDelegate?
    var isPlaying = false
    
    var videoUrl: String? {
        didSet {
            guard let videoUrl else { return }
            self.videoUrl = videoUrl
        }
    }
    
    // MARK: - Init Methods -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods -
    
    func playVideo() {
        guard let videoUrl else { return }
        
        // Player Item
        let url = URL(string: videoUrl)!
        videoPlayerController.showsPlaybackControls = true
        
        let playerItem = AVPlayerItem(url: url)
        playerItem.canUseNetworkResourcesForLiveStreamingWhilePaused = false
        playerItem.preferredForwardBufferDuration = TimeInterval(1)
        videoPlayerController.player = AVQueuePlayer(playerItem: playerItem)
        playerLooper = AVPlayerLooper(player: videoPlayerController.player as! AVQueuePlayer, templateItem: playerItem)
        
        addSubview(videoPlayerController.view)
        constrain(videoPlayerController.view, self) { playerView, contentView in
            playerView.edges == contentView.edges
        }
        
        videoPlayerController.player?.play()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.videoPlayerController.player?.currentItem, queue: .main) { [weak self] _ in
            guard let self = self else { return }
            videoPlayerController.player?.seek(to: .zero)
            videoPlayerController.player?.play()
        }
        
        videoPlayerController.player?.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)

        isPlaying = true
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "timeControlStatus", let change = change, let newValue = change[NSKeyValueChangeKey.newKey] as? Int, let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
                let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
                let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
                if newStatus != oldStatus {
                    DispatchQueue.main.async { [weak self] in
                        if let self {
                            if newStatus == .playing || newStatus == .paused {
                                self.delegate?.videoPlayerDidStartPlaying()
                            }
                        }
                    }
                }
            }
    }
    
    func stopVideo() {
        isPlaying = false
        videoPlayerController.player?.pause()
        videoPlayerController.player?.isMuted = true
        videoPlayerController.player = nil
    }
    
    func setupUI() {
        // Tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePlayOrPause(_:)))
        self.addGestureRecognizer(tapGesture)
        self.videoPlayerController.view.isUserInteractionEnabled = false
        tapGesture.numberOfTapsRequired = 1
        tapGesture.cancelsTouchesInView = false
    }
    
    @objc func handlePlayOrPause(_ sender: UITapGestureRecognizer? = nil) {
        if isPlaying {
            self.videoPlayerController.player?.pause()
        } else {
            self.videoPlayerController.player?.play()
        }
        
        isPlaying = !isPlaying
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
