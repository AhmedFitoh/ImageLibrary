//
//  Endpoints.swift
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//

import Foundation

protocol Requestable {
    var httpMethod: String {get}
    var url: String {get}
}

enum Endpoints: Requestable{
    case fetchImageList
}

extension Endpoints{
    private var baseURL: String {
        return "https://picsum.photos/v2/"
    }
    
    var httpMethod: String {
        switch self {
        case .fetchImageList:
            return "GET"
        }
    }
    
    var url: String{
        switch self {
        case .fetchImageList:
            return baseURL + "list"
        }
    }
}

