//
//  ImageListPresenterProtocols.swift
//
//  Created by AhmedFitoh on 10/10/21.
//  
//

// VIPER Protocol to the Module
protocol ImageListDelegate: AnyObject {
    
}

// VIPER Protocol for communication from Interactor -> Presenter
protocol ImageListInteractorToPresenterProtocol: AnyObject {
    func imagesFetchSuccess(_ list: ImageList)
    func imagesFetchFail(_ error: Error)
}

// VIPER Protocol for communication from View -> Presenter
protocol ImageListViewToPresenterProtocol: AnyObject {
    var list: [ImageListCellType] {get}
    func viewDidFinishLoading()
    func willDisplayCellAt(index: Int)
    func userDidSelectItem(at: Int)
}
