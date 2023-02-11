//
//  IMDBMoviesDependencies.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import UIKit

final class IMDBMoviesDependencies {
    private let remoteDataSource: RemoteDataSource
    
    init(remoteDataSource: RemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

extension IMDBMoviesDependencies: MoviesCoordinatorDependencies {
    func movieListViewController() -> UIViewController {
        let moviesRepository = MoviesRepository(remoteDataSource: remoteDataSource)
        let topMoviesInteraction = TopMoviesInteractor(moviesProvider: moviesRepository)
        let movieListViewModel = IMDBMovieListViewModel(topMoviesInteraction: topMoviesInteraction)
        return MoviesListViewController.create(with: movieListViewModel)
    }
}
