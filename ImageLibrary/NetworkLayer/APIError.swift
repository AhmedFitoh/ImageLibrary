//
//  APIError.swift
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//

import Foundation

enum APIError: Error {
    case requestFailed(description: String)
    case jsonConversionFailure(description: String)
    case invalidData
    case responseUnsuccessful(statusCode: Int, info: ErrorModel?)
    case jsonParsingFailure
    case createURLRequestFailed(error: NSError)
    case invalidUrl
}
