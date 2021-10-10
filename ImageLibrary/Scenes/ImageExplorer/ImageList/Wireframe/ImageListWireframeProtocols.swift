//
//  ImageListWireframeProtocols.swift
//
//  Created by AhmedFitoh on 10/10/21.
//  
//

// VIPER Module Constants
struct ImageListConstants {
    
    static let navigationControllerIdentifier = "ImageListNavigationController"    
    static let storyboardIdentifier = "ImageList"
    static let viewControllerIdentifier = "ImageListView"
}

// VIPER Protocol for communication from Presenter -> Wireframe
protocol ImageListPresenterToWireframeProtocol: AnyObject {
    
    func navigateToFullScreenViewer(_ url: String?)
}
