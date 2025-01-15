//
//  CoordinatorContract.swift
//  LiveStream
//
//  Created by Nivedita Angadi on 03/01/25.
//

import Foundation

public enum PresentationStyle {
    case present
    case push
}

public protocol CoordinatorContract: AnyObject {
   var childCoordinators: [CoordinatorContract] { get set }
   
    func start(animated: Bool)
}

extension CoordinatorContract {
    public func addSubCoordinator(_ coordinator: CoordinatorContract, animated: Bool = true) {
        childCoordinators.append(coordinator)
        coordinator.start(animated: animated)
    }
}
