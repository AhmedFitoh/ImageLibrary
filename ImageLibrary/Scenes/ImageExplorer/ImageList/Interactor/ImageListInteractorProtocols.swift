//
//  ImageListInteractorProtocols.swift
//
//  Created by AhmedFitoh on 10/10/21.
//  
//

// VIPER Protocol for communication from Presenter to Interactor
protocol ImageListPresenterToInteractorProtocol: AnyObject {
    func fetchNewImages(page: Int, numberOfItems: Int)
}
