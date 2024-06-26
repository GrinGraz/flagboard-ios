//
//  Flagboard.swift
//  
//
//  Created by Christopher Ruz on 16-05-22.
//

import Foundation
import SwiftUI

public struct Flagboard {

    private init() {}

    public static func initialize() {
        FlagboardInternal.initialize()
    }

    public static func loadFlags(
        featureFlagsMap: Dictionary<String, Any>,
        conflictStrategy: ConflictStrategy = .keep)
    {
        FlagboardInternal.loadFlags(
            featureFlagsMap: featureFlagsMap,
            conflictStrategy: conflictStrategy)
    }

    
    
    public static func open() {
        FlagboardInternal.open()
    }

    public static func getInt(key: String) -> Int {
        FlagboardInternal.getInt(key: key)
    }

    public static func getString(key: String) -> String {
        FlagboardInternal.getString(key: key)
    }

    public static func getBoolean(key: String) -> Bool {
        FlagboardInternal.getBoolean(key: key)
    }

    public static func getAll() -> Dictionary<String, Any> {
        FlagboardInternal.getRawFlags()
    }

    public static func getState() -> FBState {
        FlagboardInternal.getState()
    }

    public static func reset() {
        FlagboardInternal.reset()
    }
}
