//
//  File.swift
//  
//
//  Created by Christopher Ruz on 24-05-22.
//

import Foundation

internal let LOG_TAG = "FlagBoard"

internal func log(_ message: String) {
    print("\(LOG_TAG): \(message)")
}

internal let flagsCountMessage = "number of loaded feature flags: "
internal let unknownStateMessage = "is in a inconsistent state. Recall the FlagBoard.init(@NonNull featureFlagsMap: Map<String, Any>) function."
internal let initializedStateMessage = "is initialized."
internal let initializingStateMessage = "is initializing."
internal let tryToSafeUnsupportedTypeMsg = "try to save an unsupported data type"
internal let failedInitializationMessage = "initialization failed."
internal let flagsLoadedAndStrategyMessage = "feature flag loading strategy is: "
internal let initializedWithoutDataStateMessage = "has not feature flags loaded. First call the FlagBoard.loadFlags(@NonNull featureFlagsMap: Map<String, Any>) function."
