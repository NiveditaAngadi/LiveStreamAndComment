//
//  ImageDownloader.swift
//  LiveStream
//
//  Created by Nivedita Angadi on 07/01/25.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImage(from url: String) {
        let url = URL(string: url)!
        
        // Check for the cached image
        if let image = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = image
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            
            DispatchQueue.main.async {
                if let imageData = data, let image = UIImage(data: imageData) {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    self.image = image
                }
            }
        }
        
        task.resume()
    }
    
}
