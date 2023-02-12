//
//  MoviesCoordinator.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import UIKit

protocol MoviesCoordinatorDependencies {
    func movieListViewController(with router: MoviesRouter) -> MoviesListViewController
    func movieDetailsViewController(for movie: Movie) -> MovieDetailsViewController
}

protocol MoviesRouter {
    func showMovieDetails(for movie: Movie)
}

final class MoviesCoordinator {
    
    private let navigationController: UINavigationController
    private let dependencies: MoviesCoordinatorDependencies
    
    init(navigationController: UINavigationController,
         dependencies: MoviesCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let viewController = dependencies.movieListViewController(with: self)
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension MoviesCoordinator: MoviesRouter {
    func showMovieDetails(for movie: Movie) {
        let viewController = dependencies.movieDetailsViewController(for: movie)
        navigationController.pushViewController(viewController, animated: true)
    }
}
