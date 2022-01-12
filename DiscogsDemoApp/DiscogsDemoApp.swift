//
//  DiscogsDemoAppApp.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak
//  Copyright © 2022 IT ART - Artur Rybak. All rights reserved.
//

import SwiftUI
import Moya
import CombineMoya

@main
struct DiscogsDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ArtistReleasesView(viewModel: ArtistReleasesViewModel(service: .init(onlineRepository: .init(), offlineRepository: .init(context: persistenceController.container.viewContext), networkMonitoringService: .init())))
        }
    }
}

