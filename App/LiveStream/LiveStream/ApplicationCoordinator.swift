//
//  ApplicationCoordinator.swift
//  LiveStream
//
//  Created by Nivedita Angadi on 03/01/25.
//

import Foundation
import UIKit

class ApplicationCoordinator: CoordinatorContract {
    var childCoordinators = [CoordinatorContract]()
    
    var window: UIWindow!
    
    var rootViewController: UIViewController!
    
    func start(animated: Bool) {
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyBoard = UIStoryboard(name: "VideoPlayer", bundle: Bundle.main)
        if let videoPlayerViewController = storyBoard.instantiateInitialViewController() as? VideoPlayerViewController {
            let navigationController = UINavigationController(rootViewController: videoPlayerViewController)
            rootViewController = navigationController
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
        }
    }
}
