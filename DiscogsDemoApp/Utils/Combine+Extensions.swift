//
//  Combine+Extensions.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak on 12/01/2022.
//  Copyright © 2022 IT ART - Artur Rybak. All rights reserved.
//

import Foundation
import Combine
import CombineMoya

extension Publisher {
    func withUnretained<T: AnyObject>(_ object: T) -> AnyPublisher<(T, Output), Failure> {
        return compactMap { [weak object] value in
            object.map { ($0, value) }
        }.eraseToAnyPublisher()
    }
}
