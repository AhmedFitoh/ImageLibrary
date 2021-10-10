//
//  ImageViewerInteractor.swift
//
//  Created by AhmedFitoh on 10/10/21.
//  
//

import Foundation

class ImageViewerInteractor {
    
    // MARK: - VIPER Stack
    weak var presenter: ImageViewerInteractorToPresenterProtocol!
    
}

// MARK: - Presenter To Interactor Protocol
extension ImageViewerInteractor: ImageViewerPresenterToInteractorProtocol {
    
}
