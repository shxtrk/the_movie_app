//
//  MovieListVewController.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import UIKit

final class MoviesListViewController: UITableViewController, StoryboardInstantiable, ErrorPresentable {
    
    private lazy var searchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private var viewModel: MovieListViewModel!
    private var imagesProvider: ImagesProvider!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind(viewModel: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func configureUI() {
        tableView.estimatedRowHeight = MovieListCell.height
        tableView.rowHeight = UITableView.automaticDimension
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: NSLocalizedString("top10",
                                                                                      comment: ""))
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
    private func bind(viewModel: MovieListViewModel) {
        viewModel.screenTitle.observe(on: self) { [weak self] screenTitle in
            self?.title = screenTitle
        }
        viewModel.items.observe(on: self) { [weak self] _ in
            self?.tableView.reloadData()
        }
        viewModel.loading.observe(on: self) { [weak self] loading in
            ViewControllerLoaderView.hide()
            guard let loading = loading else {
                self?.refreshControl?.endRefreshing()
                return
            }
            switch loading {
            case .top: ()
            case .search: ViewControllerLoaderView.show()
            }
        }
        viewModel.error.observe(on: self) { [weak self] in
            self?.present(error: $0) {
                ViewControllerLoaderView.hide()
                self?.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
    }
    
    // MARK: - Actions
    
    @objc func refresh(_ sender: Any) {
        viewModel.refresh()
    }
    
    // MARK: - UITableViewDataSource, UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.reuseIdentifier,
                                                       for: indexPath) as? MovieListCell else {
            assertionFailure("Cannot dequeue reusable cell \(MovieListCell.self) with reuseIdentifier: \(MovieListCell.reuseIdentifier)")
            return UITableViewCell()
        }
        
        cell.configure(with: MovieListCellItem(movie: viewModel.items.value[indexPath.row]),
                       imagesProvider: imagesProvider)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
}

extension MoviesListViewController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchController.isActive = false
        viewModel.search(query: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cancelSearch()
    }
}

extension MoviesListViewController {
    static func create(with viewModel: MovieListViewModel, imagesProvider: ImagesProvider) -> Self {
        let viewController = Self.instantiateViewController()
        viewController.viewModel = viewModel
        viewController.imagesProvider = imagesProvider
        return viewController
    }
}
