//
//  NetworkMonitoringService.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak
//  Copyright © 2022 IT ART - Artur Rybak. All rights reserved.
//

import Foundation
import Network
import Combine

final class NetworkMonitoringService {
    let isConnectedPublisher: AnyPublisher<Bool, Never>
    
    private let pathMonitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    private let isConnectedSubject = PassthroughSubject<Bool, Never>()
    
    init() {
        isConnectedPublisher = isConnectedSubject.eraseToAnyPublisher()
        
        pathMonitor.pathUpdateHandler = { [weak self] path in
            self?.isConnectedSubject.send(path.status == .satisfied)
        }
        pathMonitor.start(queue: queue)
    }
    
    deinit {
        pathMonitor.cancel()
    }
}
