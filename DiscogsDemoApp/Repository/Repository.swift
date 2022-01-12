//
//  Repository.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak on 11/01/2022.
//  Copyright © 2022 IT ART - Artur Rybak. All rights reserved.
//

import Foundation
import Combine

enum RepositoryError: String, Error {
    case readonly = "Repository is readonly"
}

protocol Repository {
    associatedtype ItemType
    
    func all() -> AnyPublisher<[ItemType], Error>
    func update(objects: [ItemType]) -> AnyPublisher<Void, Error>
}
