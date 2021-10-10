//
//  WebServiceMock.swift
//  ImageLibraryTests
//
//  Created by AhmedFitoh on 10/10/21.
//


import Foundation
@testable import ImageLibrary

class WebServiceMock: NetworkingProtocol{
    
    func request<T>(value: T.Type,
                             from endpoint: Requestable,
                             withParameters params: [String : String?] = [:],
                             headers: [String : String]? = nil, body: Data? = nil,
                             completionHandler: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        var stubFileName = ""
        switch endpoint{
        case Endpoints.fetchImageList:
            stubFileName = "ImageList_stub"
            
        default:
            break
        }
        
        guard let data = Bundle.loadDataFromBundle(withName: stubFileName, ext: "json") else {
            completionHandler(.failure(APIError.invalidData))
            return
        }
        
        do {
            let genericModel = try JSONDecoder().decode(value, from: data)
            completionHandler(.success(genericModel))
        } catch {
            completionHandler(.failure(error))
        }
    
    }
}
