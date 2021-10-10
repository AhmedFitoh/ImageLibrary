//
//  ImageViewerWireframe.swift
//
//  Created by AhmedFitoh on 10/10/21.
//  
//

import UIKit

class ImageViewerWireframe {
    
    // MARK: - Instance Variables
    weak var viewController: UIViewController!

    // MARK:- Life cycle
    init(imageItem: ImageListElement,
         delegate: ImageViewerDelegate? = nil) {
        let storyboard = UIStoryboard(name: ImageViewerConstants.storyboardIdentifier, bundle: Bundle(for: ImageViewerWireframe.self))
        
        let view = (storyboard.instantiateViewController(withIdentifier: ImageViewerConstants.viewControllerIdentifier) as? ImageViewerView)!
        
        viewController = view
        
        let interactor = ImageViewerInteractor()
        let presenter = ImageViewerPresenter(imageItem: imageItem,
                                             wireframe: self,
                                             view: view,
                                             interactor: interactor,
                                             delegate: delegate)
        
        view.presenter = presenter
        interactor.presenter = presenter
    }
}

// MARK: - Presenter to Wireframe Protocol
extension ImageViewerWireframe: ImageViewerPresenterToWireframeProtocol {
    
    
}
