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
    
    func movieListViewController(with router: MoviesRouter) -> MoviesListViewController {
        let moviesRepository = MoviesRepository(remoteDataSource: remoteDataSource,
                                                localDataSource: MoviesPersistentStorage())
        let imagesRepository = ImagesRepository(remoteDataSource: remoteDataSource)
        let topMoviesInteraction = TopMoviesInteractor(moviesProvider: moviesRepository)
        let searchMoviesInteraction = SearchMoviesInteractor(moviesProvider: moviesRepository)
        let movieListViewModel = IMDBMovieListViewModel(topMoviesInteraction: topMoviesInteraction,
                                                        searchMoviesInteraction: searchMoviesInteraction,
                                                        moviesRouter: router)
        return MoviesListViewController.create(with: movieListViewModel,
                                               imagesProvider: imagesRepository)
    }
    
    func movieDetailsViewController(for movie: Movie) -> MovieDetailsViewController {
        let imagesRepository = ImagesRepository(remoteDataSource: remoteDataSource)
        let movieDetailsViewModel = IMDBMovieDetailsViewModel(movie: movie)
        return MovieDetailsViewController.create(with: movieDetailsViewModel,
                                                 imagesProvider: imagesRepository)
    }
}
