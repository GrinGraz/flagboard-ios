//
//  FlagboardViewModel.swift
//
//
//  Created by Andy Torres on 08-06-24.
//

import Foundation
import SwiftUI

protocol FlagboardViewModelProtocol {
    func updateFlag(key: String, isOn: Bool)
    var filteredItems: [FeatureFlagS] { get }
}

public class FlagboardViewModel: ObservableObject, FlagboardViewModelProtocol {
    
    @Published var searchText = ""
    @Published private var featureFlags: [FeatureFlagS] = []
    
    var filteredItems: [FeatureFlagS] {
        if searchText.isEmpty {
            return featureFlags
        } else {
            
            return featureFlags.filter { flag in flag.featureFlag.getKey().localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    public init() {
        featureFlags = FlagboardInternal.getFlags()
    }
    
    public func updateFlag(key: String, isOn: Bool) {
        FlagboardInternal.save(key: key, value: isOn)
        featureFlags = FlagboardInternal.getFlags()
    }
}
