//
//  MoviesPersistentStorage.swift
//  The Movie App
//
//  Created by Serhii Striuk on 12.02.2023.
//

import Foundation
import CoreData

final class MoviesPersistentStorage {
    
    private let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }
}

extension MoviesPersistentStorage: MoviesLocalDataSource {
    func create(movies: [Movie]) {
        coreDataStack.performBackgroundTask { context in
            do {
                let result = try context.fetch(MovieEntity.fetchRequest())
                for movie in result {
                    context.delete(movie)
                }
                for movie in movies {
                    let _ = MovieEntity(model: movie, context: context)
                }
                try context.save()
            } catch { () }
        }
    }
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        coreDataStack.performBackgroundTask { context in
            do {
                let fetchRequest = MovieEntity.fetchRequest()
                let movies = try context.fetch(fetchRequest)
                completion(.success(movies.map { $0.modelRepresentation }))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
}
