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
            ContentView()
                .onAppear {
                    Flagboard.initialize()
                    Flagboard.loadFlags(featureFlagsMap: MyFlags.flags)
                }
        }
    }
}


struct MyFlags {
    static let flags: [String: Any] = [
        "ff_new_home_enable": false,
        "ff_chat_bot_enable": false,
        "ff_string_value": false,
        "ff_int_value": false,
//        "ff_new_home_enable2": false,
//        "ff_chat_bot_enable2": false,
//        "ff_string_value2": false,
//        "ff_int_value2": false,
    ]
}
