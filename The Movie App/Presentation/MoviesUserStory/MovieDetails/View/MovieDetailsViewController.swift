//
//  MovieDetailsViewController.swift
//  The Movie App
//
//  Created by Serhii Striuk on 12.02.2023.
//

import UIKit

final class MovieDetailsViewController: UIViewController, StoryboardInstantiable {
    
    @IBOutlet private var tableView: UITableView!

    private var viewModel: MovieDetailsViewModel!
    private var imagesProvider: ImagesProvider!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind(viewModel: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func configureUI() {
        title = viewModel.screenTitle
    }

    private func bind(viewModel: MovieDetailsViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
}

extension MovieDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsCell.reuseIdentifier,
                                                       for: indexPath) as? MovieDetailsCell else {
            assertionFailure("Cannot dequeue reusable cell \(MovieDetailsCell.self) with reuseIdentifier: \(MovieDetailsCell.reuseIdentifier)")
            return UITableViewCell()
        }

        
        cell.configure(with: MovieDetailsCellItem(character: viewModel.items.value[indexPath.row].0,
                                                  frequency: viewModel.items.value[indexPath.row].1))

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MovieDetailsCell.height
    }
}

extension MovieDetailsViewController {
    static func create(with viewModel: MovieDetailsViewModel, imagesProvider: ImagesProvider) -> Self {
        let viewController = Self.instantiateViewController()
        viewController.viewModel = viewModel
        viewController.imagesProvider = imagesProvider
        return viewController
    }
}
