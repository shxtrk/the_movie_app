//
//  ImagesProvider.swift
//  The Movie App
//
//  Created by Serhii Striuk on 12.02.2023.
//

import Foundation

protocol ImagesProvider {
    func fetchImage(with path: String,
                    completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}
