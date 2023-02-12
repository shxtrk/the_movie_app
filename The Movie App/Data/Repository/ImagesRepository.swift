//
//  ImagesRepository.swift
//  The Movie App
//
//  Created by Serhii Striuk on 12.02.2023.
//

import Foundation

final class ImagesRepository {
    
    private let remoteDataSource: RemoteDataSource

    init(remoteDataSource: RemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

extension ImagesRepository: ImagesProvider {
    
    func fetchImage(with path: String,
                    completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
        let endpoint = IMDBEndpoints.image(with: path)
        let task = RepositoryTask()
        task.remoteTask = remoteDataSource.request(with: endpoint) { (result: Result<Data, NetworkError>) in
            let result = result.mapError { $0 as Error }
            DispatchQueue.main.async { completion(result) }
        }
        return task
    }
}
