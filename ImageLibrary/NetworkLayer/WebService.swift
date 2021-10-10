//
//  WebService.swift
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//

import Foundation

class WebService: NetworkingProtocol {
    
    /// URLSession Object
    private var session: URLSession = URLSession(configuration: .default)
    ///CompletionHandler
    private typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed(description: error.debugDescription))
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        completion(genericModel, nil)
                    } catch {
                        print(error)
                        completion(nil, .jsonConversionFailure(description: error.localizedDescription))
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                
                if let data = data {
                    do {
                        let serverSideErrorInfo = try JSONDecoder().decode(ErrorModel.self, from: data)
                        completion(nil, .responseUnsuccessful(statusCode: httpResponse.statusCode, info: serverSideErrorInfo))
                    } catch {
                        print(error)
                        completion(nil, .jsonConversionFailure(description: error.localizedDescription))
                    }
                } else {
                    completion(nil, .responseUnsuccessful(statusCode: httpResponse.statusCode, info: nil))
                }
            }
        }
        return task
    }
    
    
    
    func request<T: Decodable>(value: T.Type,
                               from endpoint: Requestable,
                               withParameters params: [String: String?] = [:],
                               headers: [String: String]? = nil,
                               body: Data? = nil,
                               completionHandler: @escaping (Result<T, Error>) -> Void){
        guard var url = URL(string: endpoint.url) else {
            completionHandler(.failure(APIError.invalidUrl))
            return
        }
        url.appendingQueryItems(params)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod
        
        headers?.forEach({ (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        })
    
        
        request.httpBody = body
        
        let task = decodingTask(with: request, decodingType: T.self) { (decoded , error) in
            DispatchQueue.main.async {
                guard let decoded = decoded as? T else {
                    if let error = error {
                        completionHandler(Result.failure(error))
                    } else {
                        completionHandler(Result.failure(APIError.invalidData))
                    }
                    return
                }
                
                completionHandler(.success(decoded))
            }
        }
        task.resume()
        
        
    }
    
}
