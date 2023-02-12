//
//  MovieEntity+CoreDataProperties.swift
//  The Movie App
//
//  Created by Serhii Striuk on 12.02.2023.
//
//

import Foundation
import CoreData

extension MovieEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        let fetchRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(MovieEntity.rank), ascending: true)]
        return fetchRequest
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var rank: Int64
    @NSManaged public var image: String?
}

extension MovieEntity : Identifiable { }
