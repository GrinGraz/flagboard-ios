//
//  File.swift
//  
//
//  Created by Christopher Ruz on 16-05-22.
//

import Foundation
import UIKit
import SwiftUI

internal struct FlagboardInternal {
    
    private static var state: FBState = .unknown
    private static var repository: Repository = FlagboardContainer().repository
    private let defaultInt = -1
    private let defaultString = ""

    internal static func initialize() {
        log(initializingStateMessage)
        state = .initialized(dataState: .ffNotLoaded)
        log(initializedStateMessage)
    }
    
    internal static func loadFlags(featureFlagsMap: Dictionary<String, Any>, conflictStrategy: ConflictStrategy = .keep) {
        repository.save(featureFlag: featureFlagsMap, conflictStrategy: conflictStrategy)
        state = .initialized(dataState: .ffLoaded)
        log("\(flagsLoadedAndStrategyMessage)\(conflictStrategy)")
    }
    
    internal static func open() {
        switch state {
        case .unknown:
            log(unknownStateMessage)
            return
        case .initialized(_):
            guard let rootViewController = getRootViewController() else { return }
            let viewModel = FlagboardViewModel()
            let flagBoardView = FlagboardView(viewModel: viewModel)
            let flagboardHosting = UIHostingController(rootView: flagBoardView)
            flagboardHosting.modalPresentationStyle = .fullScreen
            rootViewController.present(flagboardHosting, animated: true)
            return
        }
    }
    
    internal static func getInt(key: String) -> Int {
        repository.getInt(key: key).fold(
            { error in handleError(key: key, error: error, type: Int.self) as! Int },
            { $0 })
    }
    
    internal static func getString(key: String) -> String {
        repository.getString(key: key).fold(
            { error in handleError(key: key, error: error, type: String.self) as! String },
            { $0 })
    }
    
    internal static func getBoolean(key: String) -> Bool {
        repository.getBoolean(key: key).fold(
            { error in handleError(key: key, error: error, type: Bool.self) as! Bool },
            { $0 })
    }

    internal static func getRawFlags() -> Dictionary<String, Any> {
        return repository.getRawFlags().fold(
            { error in log("throws \(error). Default value was returned"); return [:]},
            { $0 })
    }
    
    internal static func getFlags() -> Array<FeatureFlagS> {
        return repository.getAll().sorted(by: { $0.featureFlag.getKey() < $1.featureFlag.getKey()})
    }
    
    internal static func getState() -> FBState {
        return state
    }
    
    internal static func reset() {
        repository.clear()
    }

    internal static func save(key: String, value: Any) {
        repository.save(key: key, value: value)
    }

    private static func handleError<T>(key: String, error: FBDataError, type: T) -> Any {
        var defaultValue: Any
        switch type {
        case _ as Int:
            defaultValue = -1
            break
        case _ as String:
            defaultValue = ""
            break
        case _ as Bool:
            defaultValue = false
            break
        default:
            defaultValue = false
            break
        }
        log("key \(key) throws \(error). Default value was returned")
        return defaultValue
    }
    
    internal static func getRootViewController() -> UIViewController? {
        guard let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
            return nil
        }
        return scene.windows.first { $0.isKeyWindow }?.rootViewController
    }
}
