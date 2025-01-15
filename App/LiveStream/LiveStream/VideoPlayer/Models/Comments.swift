//
//  Comments.swift
//  LiveStream
//
//  Created by Nivedita Angadi on 02/01/25.
//

import Foundation

struct Comments: Codable {
    let comments: [Comment]
    
    public init(comments: [Comment]) {
        self.comments = comments
    }
}
