//
//  ArtistReleasesView.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak
//  Copyright © 2022 IT ART - Artur Rybak. All rights reserved.
//

import Foundation
import SwiftUI

struct ArtistReleasesView: View {
    @ObservedObject var viewModel: ArtistReleasesViewModel
    private let fade = AnyTransition.opacity.animation(Animation.linear(duration: 0.5))
    
    var body: some View {
        Group {
            switch viewModel.output {
            case .initial:
                EmptyView()
                
            case let .loading(placeholders):
                contentView(placeholders, isPlaceholder: true)
                    .shimmer()
                
            case let .loaded(items):
                contentView(items, isPlaceholder: false)
                
            case let .error(error):
                infoView(message: error.localizedDescription,
                         imageName: "exclamationmark.triangle",
                         color: Color.red)
                
            case .empty:
                infoView(message: "There are no entries.\nPlease check your connection.",
                         imageName: "exclamationmark.bubble",
                         color: Color.yellow)
                
            }
        }.onAppear(perform: viewModel.fetch)
    }
    
    @ViewBuilder private func contentView(_ items: [Release], isPlaceholder: Bool) -> some View {
        List(items, id: \.id) {
            ArtistReleaseItemView(release: $0)
                .redacted(reason: isPlaceholder ? .placeholder : [])
        }
        .transition(fade)
    }
    
    @ViewBuilder private func infoView(message: String, imageName: String, color: Color) -> some View {
        InfoView(message: message, imageName: imageName)
            .foregroundColor(color)
            .padding(.all, 10.0)
            .transition(fade)
    }
}
