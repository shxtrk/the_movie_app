//
//  MovieListVewController.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import UIKit

final class MoviesListViewController: UIViewController, StoryboardInstantiable {
    
    @IBOutlet private var tableView: UITableView!
    
    private var viewModel: MovieListViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(viewModel: MovieListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
}

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.reuseIdentifier,
                                                       for: indexPath) as? MovieListCell else {
            assertionFailure("Cannot dequeue reusable cell \(MovieListCell.self) with reuseIdentifier: \(MovieListCell.reuseIdentifier)")
            return UITableViewCell()
        }
        
        return cell
    }
}

extension MoviesListViewController {
    static func create(with viewModel: MovieListViewModel) -> Self {
        let viewController = Self.instantiateViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
