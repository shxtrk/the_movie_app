//
//  MovieDetailsCell.swift
//  The Movie App
//
//  Created by Serhii Striuk on 12.02.2023.
//

import UIKit

final class MovieDetailsCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: MovieDetailsCell.self)
    static let height = CGFloat(60)
    
    private var item: MovieDetailsCellItem!
    
    @IBOutlet private weak var frequencyLabel: UILabel!
    
    func configure(with item: MovieDetailsCellItem) {
        self.item = item
        self.frequencyLabel.text = item.title
    }
}
