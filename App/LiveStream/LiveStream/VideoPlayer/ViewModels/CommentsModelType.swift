//
//  CommentsModelType.swift
//  LiveStream
//
//  Created by Nivedita Angadi on 09/01/25.
//

import Foundation

protocol CommentsModelType: ViewModelType {
    var comments: [Comment] { get }
}

class CommentsViewModel: CommentsModelType {
    var comments = [Comment]()
    
    weak var delegate: ViewModelContract?
    
    func setup() {
        loadData()
    }
    
    private func loadData() {
        if let jsonDataFile = Bundle.main.url(forResource: "comments", withExtension: "json") {
            if let jsonData = try? Data(contentsOf: jsonDataFile) {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let commentList = try decoder.decode(Comments.self, from: jsonData)
                    comments = commentList.comments
                    delegate?.didLoadData()
                } catch {
                    delegate?.showError(error: LiveStreamError.invalidJSON)
                }
            }
        }
    }
}
