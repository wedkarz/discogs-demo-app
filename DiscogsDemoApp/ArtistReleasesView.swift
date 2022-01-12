//
//  ArtistReleasesView.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak
//  Copyright © 2022 IT ART - Artur Rybak. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Kingfisher

struct ArtistReleasesView: View {
    @ObservedObject var viewModel: ArtistReleasesViewModel
    private let fade = AnyTransition.opacity.animation(Animation.linear(duration: 0.5))
    
    var body: some View {
        List(viewModel.releases, id: \.id) {
            ArtistReleaseItemView(release: $0)
                .redacted(reason: viewModel.isLoading ? .placeholder : [])
        }
        .onAppear(perform: viewModel.fetch)
    }
}

struct ArtistReleaseItemView: View {
    let release: Release
    
    var body: some View {
        HStack {
            KFImage(release.thumbUrl)
                .resizable()
                .frame(width: 80, height: 80)
                .padding(.horizontal, 10.0)
            
            VStack(alignment: .leading) {
                Text("\(release.title) (\(String(release.year)))")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 10.0)

                HStack {
                    HStack {
                        Image(systemName: "books.vertical.circle")
                            .font(.footnote)
                        Text("\(release.inCollection)")
                            .font(.footnote)
                    }
                    HStack {
                        Image(systemName: "heart.text.square")
                            .font(.footnote)
                        Text("\(release.inWantlist)")
                            .font(.footnote)
                    }
                }
            }
            
        }
    }
}
