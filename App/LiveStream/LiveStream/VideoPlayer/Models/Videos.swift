//
//  Videos.swift
//  LiveStream
//
//  Created by Nivedita Angadi on 02/01/25.
//

import Foundation

struct Videos: Codable {
    let videos: [Video]
    
    public init(_ videos: [Video]) {
        self.videos = videos
    }
}

