//
//  ViewModel.swift
//  LiveStream
//
//  Created by Nivedita Angadi on 02/01/25.
//

import Foundation

protocol ViewModelContract: AnyObject {
    func willLoadData()
    func didLoadData()
    func showError(error: Error)
}

protocol ViewModelType {
    func setup()
    var delegate: ViewModelContract? { get set }
}
