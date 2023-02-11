//
//  Movie.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import Foundation

struct Movie: Identifiable, Decodable {
    typealias ID = String
    
    let id: ID
    let title: String?
    let rank: String?
    let image: String?
    
    init(id: ID,
         title: String? = nil,
         rank: String? = nil,
         image: String? = nil) {
        self.id = id
        self.title = title
        self.rank = rank
        self.image = image
    }
}
