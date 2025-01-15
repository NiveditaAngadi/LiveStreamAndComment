//
//  VideoPlayerCollectionViewCell.swift
//  LiveStream
//
//  Created by Nivedita Angadi on 04/01/25.
//

import UIKit
import Cartography
import AVKit
import SwiftUICore

class VideoPlayerCollectionViewCell: UICollectionViewCell, VideoPlayerHolderViewDelegate {
    private let videoInfoView = UIStackView()
    private let playerHolderView = VideoPlayerHolderView()
    private let commentsView = CommentsHolderView()
    
    private let likeCountLabel = UILabel()
    private let userNameLabel = UILabel()
    private let profilePictureImageView = UIImageView()
    private let topicLabel = UILabel()
    private var likeImage = UIImageView()
    private var viewersCountLabel = UILabel()
    
    var videoUrl: String? {
        didSet {
            guard let videoUrl else { return }
            self.videoUrl = videoUrl
            playerHolderView.videoUrl = videoUrl
        }
    }
    
    var comments: [Comment]? {
        didSet {
            guard let comments else { return }
            self.commentsView.comments = comments
        }
    }
    
    var videoModel: Video? {
        didSet {
            guard let videoModel else { return }
            self.videoModel = videoModel
            setupModel(videoModel)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Clear Comments
        
        // Clear Player
        profilePictureImageView.image = nil
        userNameLabel.text = ""
        playerHolderView.stopVideo()
    }
    
    private func setupModel(_ model: Video) {
        userNameLabel.text = model.userName
        
        if let likes = model.videoLikes, likes > 0 {
            likeCountLabel.text = "\(likes)"
            likeCountLabel.isHidden = false
        } else {
            likeCountLabel.isHidden = true
        }
        
        if let urlString = model.profilePicUrl {
            profilePictureImageView.loadImage(from: urlString)
        }
        
        if let topic = model.videoTopic {
            topicLabel.text = topic
        }
        
        if let viewersCount = model.viewersCount {
            viewersCountLabel.text = "\(viewersCount)"
        }
    }
  
    private func setupUI() {
        playerHolderView.delegate = self

        // Video Player
        contentView.addSubview(playerHolderView)
        constrain(playerHolderView, contentView) { playerView, contentView in
            playerView.edges == contentView.edges
        }
        
        // Comments holder view
        contentView.addSubview(commentsView)
        constrain(commentsView, contentView) { commentsView, contentView in
            commentsView.bottom == contentView.bottom
            commentsView.leading == contentView.leading
            commentsView.trailing == contentView.trailing
            commentsView.height == 333
        }
        
        // Hide commentsView
        commentsView.isHidden = true
        
        // UserInfo view setup
        let userInfoView = UIStackView()
        userInfoView.axis = .vertical
        userInfoView.spacing = 5
        
        let userDataStackView = UIStackView()
        userDataStackView.axis = .horizontal
        
        userNameLabel.font = UIFont.systemFont(ofSize: 10)
        userNameLabel.textColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 1, alpha: 1)
        userNameLabel.textAlignment = .left
        
        profilePictureImageView.layer.cornerRadius = 6
        userDataStackView.addArrangedSubview(profilePictureImageView)
        constrain(profilePictureImageView) { profilPic in
            profilPic.width == 22
            profilPic.height == 22
        }
        
        userDataStackView.addArrangedSubview(userNameLabel)
        
        let userNameAndLikeCountStackView = UIStackView()
        userNameAndLikeCountStackView.axis = .vertical
        
        // Like Count Stack View
        let likeCountStackView = UIStackView()
        likeCountStackView.axis = .horizontal
    
        likeCountLabel.font = UIFont.systemFont(ofSize: 10)
        likeCountLabel.textColor = #colorLiteral(red: 0.882971704, green: 0.8829715848, blue: 0.882971704, alpha: 1)
        
        likeImage = UIImageView(image: UIImage(named: "mdi_heart"))
        constrain(likeImage) { likeImage in
            likeImage.width == 9
            likeImage.height == 9
        }

        likeCountStackView.addArrangedSubview(likeImage)
        likeCountStackView.addArrangedSubview(likeCountLabel)
        
        userNameAndLikeCountStackView.addArrangedSubview(userNameLabel)
        userNameAndLikeCountStackView.addArrangedSubview(likeCountStackView)
        
        userDataStackView.addArrangedSubview(profilePictureImageView)
        userDataStackView.addArrangedSubview(userNameAndLikeCountStackView)
        
        // Follow
        let followImage = UIImageView(image: UIImage(named: "follow"))
        constrain(followImage) { likeImage in
            likeImage.width == 84
            likeImage.height == 22
        }
        
        let userInfoAndFollowStackView = UIStackView()
        userInfoAndFollowStackView.axis = .horizontal
        userInfoAndFollowStackView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
        userInfoAndFollowStackView.layer.cornerRadius = 8
        userInfoAndFollowStackView.spacing = 2.0
        
        userInfoAndFollowStackView.addArrangedSubview(userDataStackView)
        userInfoAndFollowStackView.addArrangedSubview(followImage)
        
        userInfoView.addArrangedSubview(userInfoAndFollowStackView)

        // Topic Info
        let topicStackView = UIStackView()
        topicStackView.axis = .horizontal
        topicStackView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
        topicStackView.spacing = 2.0
        
        topicLabel.font = UIFont.systemFont(ofSize: 10)
        topicLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let topicImage = UIImageView(image: UIImage(named: "star-comment-alt"))
        constrain(topicImage) { topicImage in
            topicImage.width == 11
            topicImage.height == 11
        }
        
        topicStackView.addArrangedSubview(topicImage)
        topicStackView.addArrangedSubview(topicLabel)

        // Popular Live
        let popularLiveStackView = UIStackView()
        popularLiveStackView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
        popularLiveStackView.axis = .horizontal
        
        let popularLiveImageView = UIImageView(image: UIImage(named: "noto_star"))
        constrain(popularLiveImageView) { image in
            image.width == 12
            image.height == 12
        }
        
        popularLiveStackView.addArrangedSubview(popularLiveImageView)
        
        let popularLiveLabel = UILabel()
        popularLiveLabel.text = "Popular Live"
        popularLiveLabel.font = UIFont.systemFont(ofSize: 10)
        popularLiveLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        popularLiveStackView.addArrangedSubview(popularLiveLabel)
        
        let topicAndPopularLiveStackView = UIStackView()
        topicAndPopularLiveStackView.axis = .horizontal
        topicAndPopularLiveStackView.addArrangedSubview(topicStackView)
        topicAndPopularLiveStackView.addArrangedSubview(popularLiveStackView)
        
        userInfoView.addArrangedSubview(userInfoAndFollowStackView)
        userInfoView.addArrangedSubview(topicAndPopularLiveStackView)
        
        contentView.addSubview(userInfoView)
        constrain(userInfoView, contentView) { userInfoView, containerView in
            userInfoView.leading == containerView.leading + 10
            userInfoView.top == containerView.top + 50
        }
        
        // Viewers info stack view
        let viewersInfoStackView = UIStackView()
        viewersInfoStackView.axis = .vertical
        viewersInfoStackView.spacing = 4.0
        
        let viewersCountStackView = UIStackView()
        viewersCountStackView.axis = .horizontal
        viewersCountStackView.distribution = .fillProportionally
        viewersInfoStackView.alignment = .center
        viewersCountStackView.layer.cornerRadius = 6
        viewersCountStackView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
        
        viewersCountLabel.textColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1)
        viewersCountLabel.font = UIFont.systemFont(ofSize: 10)
        let viewersImage = UIImageView(image: UIImage(named: "icon_user"))
        viewersImage.contentMode = .scaleAspectFit
        constrain(viewersImage) { viewersImage in
            viewersImage.width == 13
            viewersImage.height == 13
        }
        
        viewersCountStackView.addArrangedSubview(viewersImage)
        viewersCountStackView.addArrangedSubview(viewersCountLabel)
                        
        let downImage = UIImageView(image: UIImage(systemName: "chevron.down.circle"))
        constrain(downImage) { downImage in
            downImage.width == 18
            downImage.height == 18
        }
        
        let viewersCountTopView = UIStackView()
        viewersCountTopView.axis = .horizontal
        viewersCountTopView.spacing = 0
        
        viewersCountTopView.addArrangedSubview(viewersCountStackView)
        viewersCountTopView.addArrangedSubview(downImage)
        
        let close = UIImageView(image: UIImage(named: "iconoir_cancel"))
        constrain(close) { close in
            close.width == 18
            close.height == 18
        }
        
        viewersCountTopView.addArrangedSubview(close)
        
        viewersInfoStackView.addArrangedSubview(viewersCountTopView)
        
        contentView.addSubview(viewersInfoStackView)
        constrain(viewersInfoStackView, contentView) { viewersInfoStackView, containerView in
            viewersInfoStackView.top == containerView.top + 50
            viewersInfoStackView.trailing == containerView.trailing - 10
        }
        
        // Explore
        let exploreStackView = UIStackView()
        exploreStackView.axis = .horizontal
        
        let backGround = UIImageView(image: UIImage(named: "RectangleBackground"))
        constrain(backGround) { backGround in
            backGround.width == 76
        }
        exploreStackView.addSubview(backGround)
      
        
        let planetImage = UIImageView(image: UIImage(named: "planet"))
        planetImage.contentMode = .scaleAspectFit
        
        constrain(planetImage) { planet in
            planet.width == 24
            planet.height == 24
        }
        exploreStackView.addArrangedSubview(planetImage)
        
        let exploreLabel = UILabel()
        exploreLabel.text = "Explore"
        exploreLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        exploreLabel.textColor = .white
        
        exploreStackView.addArrangedSubview(exploreLabel)
        
        let backImage = UIImageView(image: UIImage(named: "Icon_back"))
        constrain(backImage) { back in
            back.width == 10
            back.height == 10
        }
        exploreStackView.addArrangedSubview(backImage)
        
        viewersInfoStackView.addArrangedSubview(exploreStackView)
        
        let viewerCountBottomStackView = UIStackView()
        viewerCountBottomStackView.axis = .horizontal
        viewerCountBottomStackView.spacing = 10
        viewerCountBottomStackView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
        viewerCountBottomStackView.distribution = .fillEqually
        viewerCountBottomStackView.layer.cornerRadius = 6

        constrain(viewerCountBottomStackView) { bottomView in
            bottomView.height == 28 ~ 999
            bottomView.width == 79
        }
        
        let countImage = UIImageView(image: UIImage(named: "selection"))
        viewerCountBottomStackView.addArrangedSubview(countImage)
        countImage.contentMode = .scaleAspectFit
        constrain(countImage) { image in
            image.width == 15
            image.height == 12
        }
        
        let roseImage = UIImageView(image: UIImage(named: "noto_rose"))
        viewerCountBottomStackView.addArrangedSubview(roseImage)
        roseImage.contentMode = .scaleAspectFit
        constrain(roseImage) { image in
            image.width == 23
            image.height == 23
        }
        viewersInfoStackView.addArrangedSubview(viewerCountBottomStackView)
    }
    
    func playVideo() {
        playerHolderView.playVideo()
    }
    
    func pauseVideo() {
        playerHolderView.stopVideo()
    }
    
    func stopVideo() {
        playerHolderView.stopVideo()
    }
    
    // MARK: - VideoPlayerHolderViewDelegate -
    
    func videoPlayerDidStartPlaying() {
        commentsView.isHidden = false
    }
}
