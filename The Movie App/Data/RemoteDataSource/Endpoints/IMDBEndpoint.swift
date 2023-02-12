//
//  IMDBEndpoints.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import Foundation

struct IMDBEndpoint<R>: Endpoint {
    
    typealias Response = R
    
    let method: HTTPMethod
    let path: String
    let expression: String?
    
    func url(with configuration: NetworkConfiguration) throws -> URL {
        var url = configuration.baseURL.absoluteString
        if url.last != "/" { url += "/" }
        url += configuration.language + "/API"
        url += path
        url += "/\(configuration.apiKey)"
        if let expression = expression {
            url += "/\(expression)"
        }
        guard let url = URL(string: url) else {
            throw EnpointError.url
        }
        return url
    }
    
    init(method: HTTPMethod, path: String, expression: String? = nil) {
        self.method = method
        self.path = path
        self.expression = expression
        self.responseDecoder = JSONResponseDecoder()
    }
    
    var responseDecoder: ResponseDecoder
}

struct IMDBDataEndpoint<R>: Endpoint {
    
    typealias Response = R
    
    let method: HTTPMethod
    let path: String
    
    func url(with configuration: NetworkConfiguration) throws -> URL {
        guard let url = URL(string: path) else {
            throw EnpointError.url
        }
        return url
    }
    
    init(method: HTTPMethod, path: String) {
        self.method = method
        self.path = path
        self.responseDecoder = RawDataResponseDecoder()
    }
    
    var responseDecoder: ResponseDecoder
}

struct IMDBEndpoints {
    struct MoviesResponse: Decodable {
        let items: [Movie]
    }
    
    struct SearchResponse: Decodable {
        let items: [Movie]
        
        enum CodingKeys: String, CodingKey {
            case items = "results"
        }
    }
    
    static let topMovies: IMDBEndpoint<MoviesResponse> = IMDBEndpoint<MoviesResponse>(method: .get,
                                                                                      path: "/Top250Movies")
    
    static func searchMovies(with query: String) -> IMDBEndpoint<SearchResponse> {
        return IMDBEndpoint<SearchResponse>(method: .get,
                                            path: "/SearchMovie",
                                            expression: query)
    }
    
    static func image(with path: String) -> IMDBDataEndpoint<Data> {
        return IMDBDataEndpoint<Data>(method: .get, path: path)
    }
}
