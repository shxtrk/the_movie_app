//
//  MovieListCellItem.swift
//  The Movie App
//
//  Created by Serhii Striuk on 12.02.2023.
//

import Foundation

struct MovieListCellItem: Equatable {
    let title: String
    let rank: String
    let image: String?
    
    init(movie: Movie) {
        self.title = movie.title ?? ""
        self.rank = "Rank: " + (movie.rank ?? "-")
        self.image = movie.image
    }
}
