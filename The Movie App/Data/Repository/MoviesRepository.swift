//
//  MoviesRepository.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import Foundation

final class MoviesRepository {

    private let remoteDataSource: RemoteDataSource
    private let localDataSource: MoviesLocalDataSource
    
    init(remoteDataSource: RemoteDataSource,
         localDataSource: MoviesLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
}

extension MoviesRepository: MoviesProvider {
    
    func topMovies(stored: @escaping ([Movie]) -> Void,
                   completion: @escaping (Result<([Movie]), Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        localDataSource.fetchMovies { result in
            if case let .success(movies) = result {
                stored(movies)
            }
            guard !task.isCancelled else { return }
            let endpoint = IMDBEndpoints.topMovies
            task.remoteTask = self.remoteDataSource.request(with: endpoint) { result in
                switch result {
                case .success(let response):
                    let movies = Array(response.items.prefix(10))
                    self.localDataSource.create(movies: movies)
                    completion(.success(movies))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        return task
    }
    
    func searchMovies(query: String,
                      completion: @escaping (Result<([Movie]), Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        let endpoint = IMDBEndpoints.searchMovies(with: query)
        task.remoteTask = self.remoteDataSource.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let movies = Array(response.items.prefix(10))
                self.localDataSource.create(movies: movies)
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
}
