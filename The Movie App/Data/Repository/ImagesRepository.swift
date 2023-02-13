//
//  ImagesRepository.swift
//  The Movie App
//
//  Created by Serhii Striuk on 12.02.2023.
//

import Foundation

final class ImagesRepository {
    
    private let remoteDataSource: RemoteDataSource
    private let cachedImages = NSCache<NSURL, NSData>()

    init(remoteDataSource: RemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

extension ImagesRepository: ImagesProvider {
    
    func fetchImage(with path: String,
                    completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
        
        if let cached = cachedImages.object(forKey: NSURL(fileURLWithPath: path)) {
            DispatchQueue.main.async { completion(.success(cached as Data)) }
            return nil
        }
        
        let endpoint = IMDBEndpoints.image(with: path)
        let task = RepositoryTask()
        task.remoteTask = remoteDataSource.request(with: endpoint) { (result: Result<Data, NetworkError>) in
            let result = result.mapError { $0 as Error }
            if case let .success(data) = result {
                self.cachedImages.setObject(data as NSData,
                                            forKey: NSURL(fileURLWithPath: path),
                                            cost: data.count)
            }
            DispatchQueue.main.async { completion(result) }
        }
        return task
    }
}
