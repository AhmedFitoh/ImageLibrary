//
//  ImageListPresenter.swift
//
//  Created by AhmedFitoh on 10/10/21.
//  
//

import Foundation

class ImageListPresenter {
    
    // MARK: - VIPER Stack
    weak var view: ImageListPresenterToViewProtocol!
    var interactor: ImageListPresenterToInteractorProtocol!
    var wireframe: ImageListPresenterToWireframeProtocol!
    
    // MARK: - Instance Variables
    weak var delegate: ImageListDelegate?
    private let itemsThreshold = 10
    private var loadingOnProgress = false
    private var reachedTheEnd = false
    private var lastItemIndex = 0
    var list: [ImageListCellType] = []
    var pageNumber = 0
    
    
    // MARK: - Life Cycle
    init(wireframe: ImageListPresenterToWireframeProtocol, view: ImageListPresenterToViewProtocol, interactor: ImageListPresenterToInteractorProtocol, delegate: ImageListDelegate? = nil) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.view = view
        self.delegate = delegate
    }
    

    private func fetchNewPage(){
        if loadingOnProgress || reachedTheEnd {
            return
        }
        view?.showLoadingIndicator()
        loadingOnProgress = true
        interactor.fetchNewImages(page: pageNumber + 1, numberOfItems: itemsThreshold)
    }
    
}

// MARK: - Interactor to Presenter Protocol
extension ImageListPresenter: ImageListInteractorToPresenterProtocol {
    func imagesFetchSuccess(_ list: ImageList) {
        loadingOnProgress = false
        pageNumber += 1
        if list.isEmpty {
            reachedTheEnd = true
            return
        }
        let newImagesWithAds = AdsInjector().injectAdsIn(list)
        let newItemsCount = newImagesWithAds.count
        let oldItemsCount = self.list.count
        self.list.append(contentsOf: newImagesWithAds)
        let newIndices = oldItemsCount..<(oldItemsCount + newItemsCount)
        lastItemIndex = newIndices.upperBound - 1
        view?.addCellWith(indices: newIndices)
        view?.hideLoadingIndicator()
    }
    
    func imagesFetchFail(_ error: Error) {
        loadingOnProgress = false
        view?.showAlert(title: nil, message: error.localizedDescription, completionHandler: nil)
        view?.hideLoadingIndicator()
    }
    
    
}

// MARK: - View to Presenter Protocol
extension ImageListPresenter: ImageListViewToPresenterProtocol {

    func userDidSelectItem(at index: Int) {
        switch list [index] {
        case .imageCell(let item):
            if let imageListItem = item as? ImageListElement{
                wireframe?.navigateToFullScreenViewer(imageListItem)
            }
        case .adCell:
            view?.showAlert(title: nil,
                            message:"ImageList_AdsNotAvailable".localized,
                            completionHandler: nil)
        }
    }
   
    func willDisplayCellAt(index: Int) {
        if index == lastItemIndex {
            fetchNewPage()
        }
    }
    
    func viewDidFinishLoading() {
        fetchNewPage()
    }
    
}
