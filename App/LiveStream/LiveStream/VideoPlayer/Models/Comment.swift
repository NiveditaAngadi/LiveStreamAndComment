//
//  Comment.swift
//  LiveStream
//
//  Created by Nivedita Angadi on 02/01/25.
//

import Foundation

struct Comment: Codable {
    let commentId: Int
    let userName: String
    var picUrl: String?
    let comment: String
    
    enum CodingKeys: String, CodingKey {
        case commentId = "id"
        case userName = "username"
        case picUrl = "picURL"
        case comment
    }
    
    public init(commentId: Int, userName: String, picUrl: String? = nil, comment: String) {
        self.commentId = commentId
        self.userName = userName
        self.picUrl = picUrl
        self.comment = comment
    }
}
