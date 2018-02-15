//
//  Network.swift
//  Marvel
//
//  Created by thales.garcia on 13/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]

let defautArrayKey: String = "jsonArray"

enum RequestHTTPMethod {
    case get
    case post
    case put
    case delete
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }
}

struct NetworkHTTPResponse {
    
    static func empty() -> NetworkHTTPResponse {
        return NetworkHTTPResponse(code: nil, data: nil, stringServerTime: nil, headers: nil, serverError: nil, requestName: "")
    }
    
    var json: JSONDictionary? {
        if let safeData = data, let deserealizedJson = try? JSONSerialization.jsonObject(with: safeData, options: []) {
            if let jsonArray = deserealizedJson as? [JSONDictionary] {
                return [defautArrayKey: jsonArray]
            } else if let json = deserealizedJson as? JSONDictionary {
                return json
            }
        }
        return nil
    }
    
    let code: Int?
    let data: Data?
    let stringServerTime: String?
    let headers: [AnyHashable: Any]?
    let serverError: ServerError?
    let requestName: String
}

class Network {
    private var defaultHeader = ["Content-Type": "application/json", "Accept": "application/json"]
    private var task: URLSessionDataTask?
    
    func request(endpoint: Endpoint, completion: @escaping (_ response: NetworkHTTPResponse) -> Void) {
        
        guard let request = createRequest(endpoint, headers: defaultHeader) else {
            completion(NetworkHTTPResponse.empty())
            return
        }
        
        execute(request: request, endpoint: endpoint, completion: completion)
    }
    
    func downloadImage(url: URL, completion: @escaping (_ imageData: Data?)->Void) {
    
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(data)
        }
        task?.resume()
    }
    
    // MARK: - Private methods
    fileprivate func execute(request: NSMutableURLRequest, endpoint: Endpoint, completion: @escaping (_ response: NetworkHTTPResponse) -> Void) {
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(NetworkHTTPResponse.empty())
                session.finishTasksAndInvalidate()
                return
            }
            
            var serverTime: String?
            if let serverDateString = httpResponse.allHeaderFields["Date"] as? String {
                serverTime = serverDateString
            }
                        
            let kuririnHTTPResponse = NetworkHTTPResponse(code: httpResponse.statusCode,
                                                          data: data,
                                                          stringServerTime: serverTime,
                                                          headers: httpResponse.allHeaderFields,
                                                          serverError: ServerError(json: nil, statusCode: httpResponse.statusCode),
                                                          requestName: request.requestName)
            completion(kuririnHTTPResponse)
            
            session.finishTasksAndInvalidate()
        }
        task?.resume()
    }
    
    fileprivate func createRequest(_ endpoint: Endpoint, headers: [String: String]? = nil) -> NSMutableURLRequest? {
        let url = createEnpoint(endpoint)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = endpoint.method.name
        request.httpBody = createBody(endpoint)
        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        endpoint.headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }
    
    fileprivate func createEnpoint(_ endpoint: Endpoint) -> URL {
        
        switch endpoint.task {
        case .requestPlain:
            return endpoint.baseURL.appendingPathComponent(endpoint.path)
            
        case let .requestCompositeBodyData(_, urlParameters):
            return endpoint.baseURL.appendingPathComponent(endpoint.path.appendParametersAsQueryString(parameters: urlParameters))
            
        case let .requestParameters(parameters):
            if case .get = endpoint.method {
                
                let pathWithQuery = endpoint.path.appendParametersAsQueryString(parameters: parameters)
                let path = endpoint.baseURL.appendingPathComponent(pathWithQuery).absoluteString
                
                if let decodedPath = path.removingPercentEncoding, let url = URL(string: decodedPath) {
                    return url
                } else {
                    return endpoint.baseURL
                }
                
            } else {
                return endpoint.baseURL.appendingPathComponent(endpoint.path)
            }
        }
    }
    
    fileprivate func createBody(_ endpoint: Endpoint) -> Data? {
        
        switch  endpoint.task {
        case .requestPlain:
            return nil
            
        case let .requestCompositeBodyData(data, _):
            return data
            
        case let .requestParameters(parameters):
            if case .get = endpoint.method {
                return nil
            } else {
                return try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            }
        }
    }
}

