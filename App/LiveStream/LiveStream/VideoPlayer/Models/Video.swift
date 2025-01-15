//
//  Videos.swift
//  LiveStream
//
//  Created by Nivedita Angadi on 02/01/25.
//

import Foundation

struct Video: Codable {
    let videoId: Int
    let userId: Int
    let userName: String
    var profilePicUrl: String?
    var videoDescription: String?
    var videoTopic: String?
    var viewersCount: Int?
    var videoLikes: Int?
    let videoUrl: String
    var thumbnailUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case videoId = "id"
        case userId = "userID"
        case userName = "username"
        case profilePicUrl = "profilePicURL"
        case videoDescription = "description"
        case videoTopic = "topic"
        case viewersCount = "viewers"
        case videoLikes = "likes"
        case videoUrl = "video"
        case thumbnailUrl = "thumbnail"
    }
    
    public init(videoId: Int, userId: Int, userName: String, profilePicUrl: String? = nil, videoDescription: String? = nil, videoTopic: String? = nil, viewersCount: Int? = nil, videoLikes: Int? = nil, videoUrl: String, thumbnailUrl: String? = nil) {
        self.videoId = videoId
        self.userId = userId
        self.userName = userName
        self.profilePicUrl = profilePicUrl
        self.videoDescription = videoDescription
        self.videoTopic = videoTopic
        self.viewersCount = viewersCount
        self.videoLikes = videoLikes
        self.videoUrl = videoUrl
        self.thumbnailUrl = thumbnailUrl
    }
}
