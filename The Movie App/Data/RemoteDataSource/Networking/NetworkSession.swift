//
//  NetworkSession.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import Foundation

protocol NetworkSession {
    func request(_ request: URLRequest,
                 completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellable
}

class SharedNetworkSession: NetworkSession {
    
    init() { }
    
    func request(_ request: URLRequest,
                 completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellable {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}
