//
//  Endpoint.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import Foundation

enum EnpointError: Error {
    case url
}

enum HTTPMethod: String {
    case post    = "POST"
    case get     = "GET"
    case put     = "PUT"
    case delete  = "DELETE"
}

protocol Endpoint {
    
    associatedtype Response
    
    var method: HTTPMethod { get }

    var responseDecoder: ResponseDecoder { get }
    
    func url(with configuration: NetworkConfiguration) throws -> URL
}
