//
//  ImageListInteractor.swift
//
//  Created by AhmedFitoh on 10/10/21.
//  
//

import Foundation

class ImageListInteractor {
    
    // MARK: - VIPER Stack
    weak var presenter: ImageListInteractorToPresenterProtocol!
    let webService: NetworkingProtocol
    
    init(webService: NetworkingProtocol = WebService()) {
        self.webService = webService
    }
    
}

// MARK: - Presenter To Interactor Protocol
extension ImageListInteractor: ImageListPresenterToInteractorProtocol {
    
    func fetchNewImages(page: Int, numberOfItems: Int) {
        let params = ["page": "\(page)",
                      "limit": "\(numberOfItems)"]
        webService.request(value: ImageList.self,
                           withParameters: params,
                           from: Endpoints.fetchImageList) {[weak self] result in
            switch result {
            case .success(let list):
                self?.presenter?.imagesFetchSuccess(list)
            case .failure(let error):
                self?.presenter?.imagesFetchFail(error)
            }
        }
    }
    
}
