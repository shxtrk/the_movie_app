//
//  MoviesLocalDataSource.swift
//  The Movie App
//
//  Created by Serhii Striuk on 12.02.2023.
//

import Foundation

protocol MoviesLocalDataSource {
    func create(movies: [Movie])
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}
