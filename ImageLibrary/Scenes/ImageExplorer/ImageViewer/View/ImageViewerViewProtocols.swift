//
//  ImageViewerViewProtocols.swift
//
//  Created by AhmedFitoh on 10/10/21.
//  
//

// VIPER Protocol for communication from Presenter -> View
protocol ImageViewerPresenterToViewProtocol: AnyObject {
    func loadImage(_ info: ImageListElement)
}
