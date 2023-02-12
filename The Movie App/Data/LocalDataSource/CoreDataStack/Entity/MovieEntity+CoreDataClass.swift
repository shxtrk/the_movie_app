//
//  MovieEntity+CoreDataClass.swift
//  The Movie App
//
//  Created by Serhii Striuk on 12.02.2023.
//
//

import Foundation
import CoreData

@objc(MovieEntity)
public class MovieEntity: NSManagedObject {
    var modelRepresentation: Movie {
        .init(id: id ?? "",
              title: title,
              rank: String(rank),
              image: image)
    }

    convenience init(model: Movie, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = model.id
        self.title = model.title
        self.rank = Int64(model.rank ?? "0") ?? 0
        self.image = model.image
    }
}
