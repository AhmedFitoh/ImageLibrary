//
//  ImageViewerPresenterProtocols.swift
//
//  Created by AhmedFitoh on 10/10/21.
//  
//

// VIPER Protocol to the Module
protocol ImageViewerDelegate: AnyObject {
    
}

// VIPER Protocol for communication from Interactor -> Presenter
protocol ImageViewerInteractorToPresenterProtocol: AnyObject {
    
}

// VIPER Protocol for communication from View -> Presenter
protocol ImageViewerViewToPresenterProtocol: AnyObject {
    var imageItem: ImageListElement {get}
    func viewDidFinishLoading()
}
