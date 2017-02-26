//
//  NetworkService.swift
//  Sixt
//
//  Created by Ranjeet on 23/02/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit
import Foundation

let maxTimeOutInterval: TimeInterval = 60
let baseURL = ""

public enum HttpMethod : String {
    case Get    = "GET"
    case Post   = "POST"
    case Put    = "PUT"
    case Delete = "DELETE"
}

func isStatusSuccess(response: HTTPURLResponse) -> Bool {
    let stauts = response.statusCode
    return stauts >= 200 && stauts < 300
}

private func urlWithParameter(baseUrl: String = baseURL
    , apiName: String
    , queryItems: [URLQueryItem]?) -> URL?
{
    let urlString = baseUrl.appending(apiName)
    var components = URLComponents(string: urlString)
    components?.queryItems = queryItems
    return components?.url
}

private func addHttpHeader(request: URLRequest, headers: [String: String]?)
{
    var request = request
    if let httpHeaders = headers
    {
        for (key, value) in httpHeaders {
            request.addValue(value, forHTTPHeaderField: key)
        }
    }
}

public func request(apiName: String
    , method: HttpMethod = .Get
    , parameter: [URLQueryItem]? = nil
    , headers: [String: String]? = nil
    , body: Data? = nil
    , policy: URLRequest.CachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
    , interval: TimeInterval = maxTimeOutInterval) -> URLRequest? {
    
    // Creat URL from baseURL and api. Also append query parameter to the URL
    guard let url = urlWithParameter(apiName: apiName, queryItems: parameter) else { return nil }
    var request = URLRequest(url: url, cachePolicy: policy, timeoutInterval: interval)
    
    // Set Http Method
    request.httpMethod = method.rawValue
    
    // Set Http Headers
    addHttpHeader(request: request, headers: headers)
    
    // Set Http Body
    request.httpBody = body
    
    return request
}

protocol NetworkServiceType {
    func send(request: URLRequest,
              completion: @escaping ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)) -> URLSessionTask
}

class NetworkService: NSObject, URLSessionDelegate {
    static let share = NetworkService()
    private override init() {    }
    
    let operationQueue = OperationQueue()
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
}

extension NetworkService: NetworkServiceType {
    func send(request: URLRequest,
              completion: @escaping ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)) -> URLSessionTask {
        let task = NetworkService.share.session.dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}
