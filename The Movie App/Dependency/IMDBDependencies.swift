//
//  IMDBDependencies.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import UIKit

final class IMDBDependencies {
    lazy var remoteDataSource: RemoteDataSource = {
        // TODO: Move to config file
        let configuration = NetworkConfiguration(baseURL: URL(string: "https://imdb-api.com/")!,
                                                 language: "en",
                                                 apiKey: "k_h1ssw4nx")
        
        return Network(configuration: configuration,
                             networkSession: SharedNetworkSession())
    }()
}

extension IMDBDependencies: AppDependencies {
    func moviesCoordinatorDependencies() -> MoviesCoordinatorDependencies {
        return IMDBMoviesDependencies(remoteDataSource: remoteDataSource)
    }
}
