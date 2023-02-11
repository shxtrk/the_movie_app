//
//  AppCoordinator.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import UIKit

protocol AppDependencies {
    func moviesCoordinatorDependencies() -> MoviesCoordinatorDependencies
}

final class AppCoordinator {
    
    private let navigationController: UINavigationController
    private let dependencies: AppDependencies

    private var moviesCoordinator: MoviesCoordinator?

    init(navigationController: UINavigationController,
         dependencies: AppDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let dependencies = dependencies.moviesCoordinatorDependencies()
        moviesCoordinator = MoviesCoordinator(navigationController: navigationController,
                                              dependencies: dependencies)
        moviesCoordinator?.start()
    }
}
