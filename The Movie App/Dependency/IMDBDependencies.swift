//
//  IMDBDependencies.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import UIKit

final class IMDBDependencies {
    
    lazy var appConfig = AppConfig()
    
    lazy var remoteDataSource: RemoteDataSource = {
        let configuration = NetworkConfiguration(baseURL: URL(string: appConfig.apiURL)!,
                                                 language: "en",
                                                 apiKey: appConfig.apiKey)
        
        return Network(configuration: configuration,
                             networkSession: SharedNetworkSession())
    }()
}

extension IMDBDependencies: AppDependencies {
    func moviesCoordinatorDependencies() -> MoviesCoordinatorDependencies {
        return IMDBMoviesDependencies(remoteDataSource: remoteDataSource)
    }
}
