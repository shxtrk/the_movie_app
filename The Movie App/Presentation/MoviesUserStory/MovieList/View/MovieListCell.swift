//
//  MovieListCell.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import UIKit

final class MovieListCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: MovieListCell.self)
    static let height = CGFloat(260)
    
    private var item: MovieListCellItem!
    private var imagesProvider: ImagesProvider!
    private var loadTask: Cancellable? {
        willSet { loadTask?.cancel() }
    }
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    func configure(with item: MovieListCellItem,
                   imagesProvider: ImagesProvider) {
        self.item = item
        self.imagesProvider = imagesProvider

        self.titleLabel.text = item.title
        self.ratingLabel.text = item.rank
        
        updateImage()
    }
    
    private func updateImage() {
        posterImageView.image = nil
        guard let imagePath = item.image else { return }

        loadTask = imagesProvider.fetchImage(with: imagePath) { [weak self] result in
            guard let self = self else { return }
            guard self.item.image == imagePath else { return }
            if case let .success(data) = result {
                self.posterImageView.image = UIImage(data: data)
            }
            self.loadTask = nil
        }
    }
}
