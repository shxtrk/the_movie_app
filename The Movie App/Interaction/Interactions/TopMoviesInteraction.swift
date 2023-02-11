//
//  TopMoviesInteraction.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import Foundation

protocol TopMoviesInteraction {
    func load(stored: @escaping ([Movie]) -> Void,
              completion: @escaping (Result<[Movie], Error>) -> Void) -> InteractionTask?
}

final class TopMoviesInteractor: TopMoviesInteraction {
    
    private let moviesProvider: MoviesProvider
    
    init(moviesProvider: MoviesProvider) {
        self.moviesProvider = moviesProvider
    }
    
    func load(stored: @escaping ([Movie]) -> Void,
              completion: @escaping (Result<[Movie], Error>) -> Void) -> InteractionTask? {
        return moviesProvider.topMovies(stored: stored, completion: completion)
    }
}
