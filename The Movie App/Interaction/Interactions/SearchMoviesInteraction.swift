//
//  SearchMoviesInteraction.swift
//  The Movie App
//
//  Created by Serhii Striuk on 12.02.2023.
//

import Foundation

protocol SearchMoviesInteraction {
    func load(search: String,
              completion: @escaping (Result<[Movie], Error>) -> Void) -> InteractionTask?
}

final class SearchMoviesInteractor: SearchMoviesInteraction {
    
    private let moviesProvider: MoviesProvider
    
    init(moviesProvider: MoviesProvider) {
        self.moviesProvider = moviesProvider
    }
    
    func load(search: String,
              completion: @escaping (Result<[Movie], Error>) -> Void) -> InteractionTask? {
        return moviesProvider.searchMovies(query: search,
                                           completion: completion)
    }
}
