//
//  ImageViewerPresenter.swift
//
//  Created by AhmedFitoh on 10/10/21.
//  
//

import Foundation

class ImageViewerPresenter {
    
    // MARK: - VIPER Stack
    weak var view: ImageViewerPresenterToViewProtocol!
    var interactor: ImageViewerPresenterToInteractorProtocol!
    var wireframe: ImageViewerPresenterToWireframeProtocol!
    
    // MARK: - Instance Variables
    weak var delegate: ImageViewerDelegate?
    let imageItem: ImageListElement
    
    // MARK: - Life Cycle
    init(imageItem: ImageListElement,
         wireframe: ImageViewerPresenterToWireframeProtocol,
         view: ImageViewerPresenterToViewProtocol,
         interactor: ImageViewerPresenterToInteractorProtocol,
         delegate: ImageViewerDelegate? = nil) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.view = view
        self.delegate = delegate
        self.imageItem = imageItem
    }
}

// MARK: - Interactor to Presenter Protocol
extension ImageViewerPresenter: ImageViewerInteractorToPresenterProtocol {
    
}

// MARK: - View to Presenter Protocol
extension ImageViewerPresenter: ImageViewerViewToPresenterProtocol {
    
    func viewDidFinishLoading() {
        view?.loadImage(imageItem)
    }
    
    
}
