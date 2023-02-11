//
//  NetworkStack.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import Foundation

public enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

extension URLSessionTask: Cancellable { }

struct NetworkConfiguration {
    let baseURL: URL
    let language: String
    let apiKey: String
}

final class APINetworking {
    
    private let configuration: NetworkConfiguration
    private let networkSession: NetworkSession
    
    public init(configuration: NetworkConfiguration,
                networkSession: NetworkSession) {
        self.configuration = configuration
        self.networkSession = networkSession
    }
    
    private func request(for request: URLRequest,
                         completion: @escaping (Result<Data?, NetworkError>) -> Void) -> Cancellable {
        
        let sessionDataTask = networkSession.request(request) { data, response, requestError in
            
            if let requestError = requestError {
                var error: NetworkError
                if let response = response as? HTTPURLResponse {
                    error = .error(statusCode: response.statusCode, data: data)
                } else {
                    error = self.resolve(error: requestError)
                }
                
                completion(.failure(error))
            } else {
                completion(.success(data))
            }
        }
        return sessionDataTask
    }
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
}

extension APINetworking: RemoteDataSource {
    
    func request<T: Decodable, E: Endpoint>(with endpoint: E,
                                            completion: @escaping (Result<T, DataTransferError>) -> Void) -> Cancellable? where E.Response == T {

        guard let urlRequest = try? urlRequest(for: endpoint, with: configuration) else {
            completion(.failure(.networkFailure(.urlGeneration)))
            return nil
        }
        
        return self.request(for: urlRequest) { result in
            switch result {
            case .success(let data):
                let result: Result<T, DataTransferError> = self.decode(data: data, decoder: endpoint.responseDecoder)
                DispatchQueue.main.async { return completion(result) }
            case .failure(let error):
                let error = self.resolve(error: error)
                DispatchQueue.main.async { return completion(.failure(.networkFailure(error))) }
            }
        }
    }
    
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder) -> Result<T, DataTransferError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            return .failure(.parsing(error))
        }
    }
    
    private func urlRequest<E: Endpoint>(for endpoint: E,
                                         with configuration: NetworkConfiguration) throws -> URLRequest {
        let url = try endpoint.url(with: configuration)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        return urlRequest
    }
}
