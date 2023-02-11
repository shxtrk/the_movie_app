//
//  IMDBEndpoints.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import Foundation

struct MoviesResponse: Decodable {
    let items: [Movie]
}

struct IMDBEndpoint<R>: Endpoint {
    
    typealias Response = R
    
    let method: HTTPMethod
    let path: String
    
    func url(with configuration: NetworkConfiguration) throws -> URL {
        var url = configuration.baseURL.absoluteString
        if url.last != "/" { url += "/" }
        url += configuration.language + "/API"
        url += path
        url += "/\(configuration.apiKey)"
        guard let url = URL(string: url) else {
            throw EnpointError.url
        }
        return url
    }
    
    init(method: HTTPMethod, path: String) {
        self.method = method
        self.path = path
        self.responseDecoder = JSONResponseDecoder()
    }
    
    var responseDecoder: ResponseDecoder
}

struct IMDBEndpoints {
    
    var topMovies: IMDBEndpoint<MoviesResponse> {
        return IMDBEndpoint<MoviesResponse>(method: .get,
                                            path: "/Top250Movies")
    }
    
}
