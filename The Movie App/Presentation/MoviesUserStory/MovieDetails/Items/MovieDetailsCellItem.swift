//
//  MovieDetailsCellItem.swift
//  The Movie App
//
//  Created by Serhii Striuk on 12.02.2023.
//

import Foundation

struct MovieDetailsCellItem: Equatable {
    let title: String
    
    init(character: Character, frequency: Int) {
        let localizedString = NSLocalizedString("character_occurrence", comment: "")
        title = String(format: localizedString, String(character), String(frequency))
    }
}
