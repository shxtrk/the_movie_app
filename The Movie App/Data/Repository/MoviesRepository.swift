//
//  MoviesRepository.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import Foundation

final class MoviesRepository {

    private let remoteDataSource: RemoteDataSource
    
    init(remoteDataSource: RemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

extension MoviesRepository: MoviesProvider {
    
    func topMovies(stored: @escaping ([Movie]) -> Void,
                   completion: @escaping (Result<([Movie]), Error>) -> Void) -> Cancellable? {
        stored([])
        
        return remoteDataSource.request(with: IMDBEndpoints().topMovies) { result in
            switch result {
            case .success(let response):
                // TODO: Save to db
                completion(.success(response.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchMovies(query: String, stored: @escaping ([Movie]) -> Void,
                      completion: @escaping (Result<([Movie]), Error>) -> Void) -> Cancellable? {
        stored([])
        return nil
    }
    

//    public func fetchMoviesList(query: MovieQuery, page: Int,
//                                cached: @escaping (MoviesPage) -> Void,
//                                completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable? {
//
//        let requestDTO = MoviesRequestDTO(query: query.query, page: page)
//        let task = RepositoryTask()
//
//        cache.getResponse(for: requestDTO) { result in
//
//            if case let .success(responseDTO?) = result {
//                cached(responseDTO.toDomain())
//            }
//            guard !task.isCancelled else { return }
//
//            let endpoint = APIEndpoints.getMovies(with: requestDTO)
//            task.networkTask = self.dataTransferService.request(with: endpoint) { result in
//                switch result {
//                case .success(let responseDTO):
//                    self.cache.save(response: responseDTO, for: requestDTO)
//                    completion(.success(responseDTO.toDomain()))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        }
//        return task
//    }
}
