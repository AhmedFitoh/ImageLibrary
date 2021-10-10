//
//  URL+AppendingQuery.swift
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//

import Foundation

extension URL {

    mutating func appendingQueryItem(name: String, value: String?) {
        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let queryItem = URLQueryItem(name: name, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        self = urlComponents.url!
    }
    
    
    mutating func appendingQueryItems(_ params: [String: String?]) {
        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        params.forEach { (key: String, value: String?) in
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponents.queryItems = queryItems
        self = urlComponents.url!
    }
}
