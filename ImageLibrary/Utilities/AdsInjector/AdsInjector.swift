//
//  AdsInjector.swift
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//

import Foundation

class AdsInjector {
    
    private let startIndex = 5
    private let adsThreshold = 5
    
    func injectAdsIn(_ list: ImageList) -> [ImageListCellType]{
        let itemsCount = list.count
        if itemsCount < 5 {
            return list.map {convertImageListElementToCellType($0)}
        }
        
        var tempList: [ImageListCellType] = list.map {convertImageListElementToCellType($0)}
        for adIndex in stride(from: startIndex, through: itemsCount , by: adsThreshold).reversed() {
            tempList.insert(adCreator(), at: adIndex)
        }
        return tempList
    }
    
    
    private func convertImageListElementToCellType(_ element: ImageListElement) -> ImageListCellType{
        return ImageListCellType.imageCell(element)
    }
    
    private func adCreator() -> ImageListCellType{
        return ImageListCellType.adCell
    }
}
