//
//  ImageListViewProtocols.swift
//
//  Created by AhmedFitoh on 10/10/21.
//  
//

// VIPER Protocol for communication from Presenter -> View
protocol ImageListPresenterToViewProtocol: AnyObject, Alertable {
    func addCellWith(indices: Range<Int>)
    func showLoadingIndicator()
    func hideLoadingIndicator()
}
