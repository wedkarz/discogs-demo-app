//
//  MessageView.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak on 12/01/2022.
//  Copyright © 2022 IT ART - Artur Rybak. All rights reserved.
//

import Foundation
import SwiftUI

struct InfoView: View {
    let message: String
    let imageName: String
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Image(systemName: imageName).font(.system(size: 48))
            Text(message).multilineTextAlignment(.center)
            Spacer()
        }
    }
}
