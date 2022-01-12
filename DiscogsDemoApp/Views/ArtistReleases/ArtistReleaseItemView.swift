//
//  ArtistReleaseItemView.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak on 12/01/2022.
//  Copyright © 2022 IT ART - Artur Rybak. All rights reserved.
//

import Foundation
import SwiftUI
import Kingfisher

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
