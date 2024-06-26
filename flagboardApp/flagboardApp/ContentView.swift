//
//  ContentView.swift
//  flagboardApp
//
//  Created by Andy Torres on 07-06-24.
//

import SwiftUI
import Flagboard

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Button("Open Flagboard") {
                    
                    Flagboard.open()
                }
            }
            .navigationBarTitle("Vista Principal")
        }
    }
}

#Preview {
    ContentView()
}
