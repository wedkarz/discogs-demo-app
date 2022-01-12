//
//  ArtistReleasesViewModell.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak
//  Copyright © 2022 IT ART - Artur Rybak. All rights reserved.
//

import Foundation
import Combine

class ArtistReleasesViewModel: ObservableObject {
    @Published var releases: [Release] = Array(repeating: Release.empty, count: 10)
    @Published var error: String = ""
    @Published var isLoading: Bool = false
    
    private let service: ArtistReleasesService
    private var disposeBag = Set<AnyCancellable>()
    
    init(service: ArtistReleasesService) {
        self.service = service
    }
    
    func fetch() {
        isLoading = true
        
        service.fetch().sink { [weak self] completion in
            self?.isLoading = false
            
            guard case let .failure(error) = completion else { return }
            self?.error = error.localizedDescription
        } receiveValue: { [weak self] value in
            self?.releases = value
            self?.isLoading = false
        }.store(in: &disposeBag)
    }
}
