//
//  RemoteDataSource.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import Foundation

protocol RemoteDataSource {
    func request<T: Decodable, E: Endpoint>(with endpoint: E,
                                            completion: @escaping (Result<T, DataTransferError>) -> Void) -> Cancellable? where E.Response == T
}
