//
//  ImageListWireframe.swift
//
//  Created by AhmedFitoh on 10/10/21.
//  
//

import UIKit

class ImageListWireframe {
    
    // MARK: - Instance Variables
    weak var viewController: UIViewController!
    weak var navigationController: UINavigationController?
    
    // MARK:- Life cycle
    init(delegate: ImageListDelegate? = nil) {
        let storyboard = UIStoryboard(name: ImageListConstants.storyboardIdentifier, bundle: Bundle(for: ImageListWireframe.self))
            
        navigationController = storyboard.instantiateViewController(withIdentifier: ImageListConstants.navigationControllerIdentifier) as? UINavigationController
        let view = navigationController?.viewControllers[0] as! ImageListView
        
        viewController = view
        
        let interactor = ImageListInteractor()
        let presenter = ImageListPresenter(wireframe: self, view: view, interactor: interactor, delegate: delegate)
        
        view.presenter = presenter
        interactor.presenter = presenter
    }
}

// MARK: - Presenter to Wireframe Protocol
extension ImageListWireframe: ImageListPresenterToWireframeProtocol {
    
    func navigateToFullScreenViewer(_ url: String?) {
        
    }

    
}
