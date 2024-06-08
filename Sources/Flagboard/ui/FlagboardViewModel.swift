//
//  FlagboardViewModel.swift
//
//
//  Created by Andy Torres on 08-06-24.
//

import Foundation
import SwiftUI

protocol FlagboardViewModelProtocol {
    
}

public class FlagboardViewModel: ObservableObject, FlagboardViewModelProtocol {
    
    @State var searchText = ""
    
    private var featureFlags: [FeatureFlagS] = [
        FeatureFlagS(featureFlag: .booleanFlag(param: .init(key: .init(value: "ff_new_home"), value: true))),
        FeatureFlagS(featureFlag: .booleanFlag(param: .init(key: .init(value: "ff_chat_enabled"), value: false))),
        FeatureFlagS(featureFlag: .stringFlag(param: .init(key: .init(value: "ff_string_value"), value: "Hello World!"))),
    ]
    
    var filteredItems: [FeatureFlagS] {
        if searchText.isEmpty {
            //return featureFlags
            return [
                FeatureFlagS(featureFlag: .booleanFlag(param: .init(key: .init(value: "ff_new_home"), value: true))),
                FeatureFlagS(featureFlag: .booleanFlag(param: .init(key: .init(value: "ff_chat_enabled"), value: false))),
                FeatureFlagS(featureFlag: .stringFlag(param: .init(key: .init(value: "ff_string_value"), value: "Hello World!"))),
            ]
        } else {
            
            return featureFlags.filter { flag in flag.featureFlag.getValue().localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    public init() {
        featureFlags = FlagboardInternal.getFlags()
    }
    
    
}
