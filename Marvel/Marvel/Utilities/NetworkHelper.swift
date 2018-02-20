//
//  NetworkHelper.swift
//  Marvel
//
//  Created by thales.garcia on 13/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

//MARK: - Extension - String
extension String {
    
    func appendParametersAsQueryString(parameters: JSONDictionary) -> String {
        let urlAsString = stringByRemovingURLParameters(parameters: parameters.keys.map { $0 })
        
        if parameters.keys.isEmpty {
            return urlAsString
        }
        
        let paramsString = parameters.parametersToString(urlHasQuery: urlAsString.hasQueryString())
        
        let combine = hasQueryString() ? (+) : { !$0.isEmpty ? $0 + "?" + $1 : $1 }
        
        return [urlAsString, paramsString].reduce("", combine)
    }
    
    func stringByRemovingURLParameters(parameters: [String]) -> String {
        var url = self
        for p in parameters {
            url = url.stringByRemovingURLParameter(parameter: p)
        }
        return url
    }
    
    func stringByReplacingURLParameterValue(parameter: String, withValue value: String) -> String {
        guard self.contains("\(parameter)=") else {
            return self
        }
        let removedParameterString = stringByRemovingURLParameter(parameter: parameter)
        return removedParameterString.contains("?") ? "\(removedParameterString)\(parameter)=\(value)" : "\(removedParameterString)?\(parameter)=\(value)"
    }
    
    func hasQueryString() -> Bool {
        if let url = URL(string: self) {
            return url.hasQueryString()
        }
        guard let equalsRange = range(of: "="), String(self[..<equalsRange.lowerBound]).range(of: "?") != nil else {
            return false
        }
        return true
    }
    
    func stringByRemovingURLParameter(parameter: String) -> String {
        
        let splitedURL = self.split{ $0 == "?" }.map{ String($0) }
        
        guard let urlBaseAndPath = splitedURL.first, let query = splitedURL.last, splitedURL.count == 2 else {
            return self
        }
        
        guard !(query.split{ $0 == "&" }.filter{ !String($0).contains("\(parameter)=") }).isEmpty else {
            return query.contains("\(parameter)=") ? urlBaseAndPath : self
        }
        
        let queryStringWithRemovedParameter = query.split{ $0 == "&" }.map{ String($0) }.filter{ !$0.contains("\(parameter)=") }.joined(separator: "&")
        return !queryStringWithRemovedParameter.isEmpty ? "\(urlBaseAndPath)?\(queryStringWithRemovedParameter)" : urlBaseAndPath
    }
    
    func urlEncodedString() -> String {
        let urlEncodedString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return urlEncodedString ?? self
    }
}

extension String {
    func MD5() -> String {
        let messageData = self.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
    
        _ = digestData.withUnsafeMutableBytes{ digestBytes in
            messageData.withUnsafeBytes{ messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
}

// MARK: - Extension - URL
extension URL {
    func hasQueryString() -> Bool {
        return self.query != nil
    }
}


// MARK: - Extension - NSMutableURLRequest
extension NSMutableURLRequest {
    
    var requestName: String {
        guard let urlPath = self.url else { return "" }
        
        let coreName = "\(self.httpMethod)\(urlPath.path)\(urlPath.pathComponents.reduce("",+))"
        return coreName.replacingOccurrences(of: "[\\[\\]^+<>./]",
                                             with: "",
                                             options: .regularExpression,
                                             range: nil)
    }
}

// MARK: - Extension - Dictionary
extension Dictionary where Key: ExpressibleByStringLiteral {
    func parametersToString(urlHasQuery: Bool = false) -> String {
        let parametersString = self.reduce("", {
            let pair = String(describing: $1.0) + "=" + String(describing: $1.1).urlEncodedString()
            return !$0.isEmpty ? $0 + "&" + pair : pair
        })
        return (urlHasQuery ? "&" : "") + parametersString
    }
}
