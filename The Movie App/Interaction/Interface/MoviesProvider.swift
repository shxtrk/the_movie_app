//
//  MoviesRepository.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import Foundation

protocol MoviesProvider {
    func topMovies(stored: @escaping ([Movie]) -> Void,
                   completion: @escaping (Result<([Movie]), Error>) -> Void) -> Cancellable?
    
    func searchMovies(query: String,
                      completion: @escaping (Result<([Movie]), Error>) -> Void) -> Cancellable?
}
