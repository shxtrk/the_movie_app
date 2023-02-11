//
//  MoviesCoordinator.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import UIKit

protocol MoviesCoordinatorDependencies {
    func movieListViewController() -> UIViewController
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
        let viewController = dependencies.movieListViewController()
        navigationController.pushViewController(viewController, animated: false)
    }
}
