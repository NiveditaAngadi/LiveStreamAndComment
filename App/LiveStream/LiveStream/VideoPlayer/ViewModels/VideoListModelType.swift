//
//  VideoListModelType.swift
//  LiveStream
//
//  Created by Nivedita Angadi on 02/01/25.
//

import Foundation

protocol VideoListModelType: ViewModelType {
    var videoList: [Video] { get }
}

class VideoListViewModel: VideoListModelType {
    var videoList = [Video]()
    
    weak var delegate: ViewModelContract?
    
    func setup() {
        loadData()
    }
    
    private func loadData() {
        if let jsonDataFile = Bundle.main.url(forResource: "videos", withExtension: "json") {
            if let jsonData = try? Data(contentsOf: jsonDataFile) {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let videos = try decoder.decode(Videos.self, from: jsonData)
                    videoList = videos.videos
                    delegate?.didLoadData()
                } catch {
                    delegate?.showError(error: LiveStreamError.invalidJSON)
                }
            }
        }
    }
}
