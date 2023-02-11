//
//  MovieListViewModel.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

protocol MovieListViewModelInput {
    func viewDidLoad()
}

protocol MovieListViewModelOutput {
     var items: Observable<[Movie]> { get }
}

typealias MovieListViewModel = MovieListViewModelInput & MovieListViewModelOutput

final class IMDBMovieListViewModel: MovieListViewModel {
    
    private let topMoviesInteraction: TopMoviesInteraction
    
    private var moviesLoadTask: InteractionTask? {
        willSet { moviesLoadTask?.cancel() }
    }
    
    // MARK: - Init
    
    init(topMoviesInteraction: TopMoviesInteraction) {
        self.topMoviesInteraction = topMoviesInteraction
    }
    
    // MARK: - Private
    
    private func update(movies: [Movie]) {
        items.value = movies
    }
    
    // MARK: - Output
    
    let items: Observable<[Movie]> = Observable([])
    
    // MARK: - Input
    
    func viewDidLoad() {
        moviesLoadTask = topMoviesInteraction.load(stored: update(movies:)) { result in
            switch result {
            case .success(let movies):
                self.update(movies: movies)
            case .failure(_):
                () // TODO: Handle error
            }
        }
    }
}
