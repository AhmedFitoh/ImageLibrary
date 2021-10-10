//
//  NetworkingProtocol.swift
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//

import Foundation


protocol NetworkingProtocol: AnyObject {
    func request<T: Decodable>(value: T.Type,
                               from endpoint: Requestable,
                               withParameters params: [String: String?],
                               headers: [String: String]?,
                               body: Data?,
                               completionHandler: @escaping (Result<T, Error>) -> Void)
    
    func request<T: Decodable>(value: T.Type,
                               withParameters params: [String: String?],
                               from endpoint: Requestable,
                               completionHandler: @escaping (Result<T, Error>) -> Void)
}

extension NetworkingProtocol{
    func request<T: Decodable>(value: T.Type,
                               from endpoint: Requestable,
                               body: Data?,
                               completionHandler: @escaping (Result<T, Error>) -> Void){
        self.request(value: value,
                     from: endpoint,
                     withParameters: [:],
                     headers: nil,
                     body: body,
                     completionHandler: completionHandler)
    }

    
    func request<T: Decodable>(value: T.Type,
                               withParameters params: [String: String?],
                               from endpoint: Requestable,
                               completionHandler: @escaping (Result<T, Error>) -> Void){
        self.request(value: value,
                     from: endpoint,
                     withParameters: params,
                     headers: nil,
                     body: nil,
                     completionHandler: completionHandler)
    }
}
