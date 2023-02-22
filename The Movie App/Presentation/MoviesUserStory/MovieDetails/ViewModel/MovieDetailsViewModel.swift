//
//  MovieDetailsViewModel.swift
//  The Movie App
//
//  Created by Serhii Striuk on 12.02.2023.
//

import Foundation

protocol MovieDetailsViewModelInput {
    func viewDidLoad()
}

protocol MovieDetailsViewModelOutput {
    var screenTitle: String { get }
    var items: Observable<[(Character, Int)]> { get }
}

typealias MovieDetailsViewModel = MovieDetailsViewModelInput & MovieDetailsViewModelOutput

final class IMDBMovieDetailsViewModel: MovieDetailsViewModel {
    
    private let movie: Movie
    private let operationQueue: OperationQueue
    
    // MARK: - Init
    
    init(movie: Movie) {
        self.movie = movie
        self.screenTitle = movie.title ?? ""
        self.operationQueue = OperationQueue()
        self.operationQueue.maxConcurrentOperationCount = 1
    }
    
    // MARK: - Output
    
    let screenTitle: String
    let items: Observable<[(Character, Int)]> = Observable([])
    
    // MARK: - Input
    
    func viewDidLoad() {
        let operation = BlockOperation { [weak self] in
            guard let title = self?.movie.title?.lowercased() else { return }
            var dict = [Character: Int]()
            title.forEach { dict[$0, default: 0] += 1 }
            let sortedItems = dict.sorted(by: { $0.value > $1.value }).map { ($0.key, $0.value) }
            OperationQueue.main.addOperation {
                self?.items.value = sortedItems
            }
        }
        operationQueue.addOperation(operation)
    }
}
