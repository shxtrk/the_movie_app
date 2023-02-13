//
//  AppConfig.swift
//  The Movie App
//
//  Created by Serhii Striuk on 13.02.2023.
//

import Foundation

final class AppConfig {
    
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    
    lazy var apiURL: String = {
        guard let apiURL = Bundle.main.object(forInfoDictionaryKey: "ApiUrl") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiURL
    }()
}
