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
                
                Button("Clear Defaults and Open flagboard") {
                    resetUserDefaults()
                    Flagboard.open()
                }
            }
            .navigationBarTitle("Principal View")
        }
    }
    
    func resetUserDefaults() {
        let dictionary = UserDefaults.standard.dictionaryRepresentation()

        dictionary.keys.forEach { UserDefaults.standard.removeObject(forKey: $0) }
    }
}

#Preview {
    ContentView()
}
