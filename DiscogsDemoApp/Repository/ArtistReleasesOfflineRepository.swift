//
//  ArtistReleaseOfflineRepository.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak on 11/01/2022.
//  Copyright © 2022 IT ART - Artur Rybak. All rights reserved.
//

import Foundation
import CoreData
import Combine

class ArtistReleasesOfflineRepository: Repository {
    typealias ItemType = Release

    private let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func all() -> AnyPublisher<[ItemType], Error> {
        do {
            return try context.fetch(ReleaseEntity.fetchRequest()).publisher
                .map { $0.model() }
                .collect()
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func update(objects: [ItemType]) -> AnyPublisher<Void, Error> {
        let existingObjectsPredicate = NSPredicate(format: "id IN %@", objects.map { $0.id })
        
        let fetchRequest = ReleaseEntity.fetchRequest()
        fetchRequest.predicate = existingObjectsPredicate
        
        do {
            let existingEntities = try context.fetch(fetchRequest)
            let existingEntitiesMap = Dictionary(uniqueKeysWithValues: existingEntities.map { ($0.id, $0) })
            let updatedObjectsMap = objects.map { ($0.id, $0) }
            
            for updatedObject in updatedObjectsMap {
                let entity = existingEntitiesMap[Int32(updatedObject.0)] ?? ReleaseEntity(context: context)
                entity.updateFromModel(updatedObject.1)
            }
            
            try context.save()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
