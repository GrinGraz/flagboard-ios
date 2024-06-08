//
//  flagboardAppApp.swift
//  flagboardApp
//
//  Created by Andy Torres on 07-06-24.
//

import SwiftUI
import Flagboard

@main
struct flagboardAppApp: App {
    var body: some Scene {
        WindowGroup {
            FlagboardView(viewModel: FlagboardViewModel())
        }
    }
}
