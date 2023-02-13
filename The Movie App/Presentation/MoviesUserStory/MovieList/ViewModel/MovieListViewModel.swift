//
//  MovieListViewModel.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import Foundation

protocol MovieListViewModelInput {
    func viewDidLoad()
    func didSelectItem(at index: Int)
    func search(query: String)
    func cancelSearch()
    func refresh()
}

protocol MovieListViewModelOutput {
    var screenTitle: Observable<String> { get }
    var items: Observable<[Movie]> { get }
    var loading: Observable<MoviesLoader?> { get }
    var error: Observable<String> { get }
}

enum MoviesLoader {
    case top
    case search
}

typealias MovieListViewModel = MovieListViewModelInput & MovieListViewModelOutput

final class IMDBMovieListViewModel: MovieListViewModel {
    
    private let topMoviesInteraction: TopMoviesInteraction
    private let searchMoviesInteraction: SearchMoviesInteraction
    private let moviesRouter: MoviesRouter
    
    private var moviesLoadTask: InteractionTask? {
        willSet { moviesLoadTask?.cancel() }
    }
    
    // MARK: - Init
    
    init(topMoviesInteraction: TopMoviesInteraction,
         searchMoviesInteraction: SearchMoviesInteraction,
         moviesRouter: MoviesRouter) {
        self.topMoviesInteraction = topMoviesInteraction
        self.searchMoviesInteraction = searchMoviesInteraction
        self.moviesRouter = moviesRouter
    }
    
    // MARK: - Private
    
    private func update(movies: [Movie]) {
        items.value = movies
    }
    
    private func loadTopMovies() {
        screenTitle.value = NSLocalizedString("top10", comment: "")
        loading.value = .top
        moviesLoadTask = topMoviesInteraction.load(stored: update(movies:)) { result in
            self.loading.value = nil
            switch result {
            case .success(let movies):
                self.update(movies: movies)
            case .failure(let error):
                self.process(error: error)
            }
        }
    }
    
    private func process(error: Error) {
        self.error.value = error.localizedDescription
    }
    
    // MARK: - Output
    
    let screenTitle: Observable<String> = Observable(NSLocalizedString("top10", comment: ""))
    let items: Observable<[Movie]> = Observable([])
    let loading: Observable<MoviesLoader?> = Observable(nil)
    let error: Observable<String> = Observable("")
    
    // MARK: - Input
    
    func viewDidLoad() {
        loadTopMovies()
    }
    
    func didSelectItem(at index: Int) {
        moviesRouter.showMovieDetails(for: items.value[index])
    }
    
    func search(query: String) {
        screenTitle.value = query
        loading.value = .search
        moviesLoadTask = searchMoviesInteraction.load(search: query) { result in
            self.loading.value = nil
            switch result {
            case .success(let movies):
                self.update(movies: movies)
            case .failure(let error):
                self.process(error: error)
            }
        }
    }
    
    func cancelSearch() {
        loadTopMovies()
    }
    
    func refresh() {
        loadTopMovies()
    }
}
