//
//  File.swift
//  
//
//  Created by Christopher Ruz on 19-05-22.
//

import Foundation

internal struct Key {
    let value: String
}

internal struct Param<T> {
    let key: Key
    let value: T
}

struct FeatureFlagS: Identifiable {
    let id = UUID()
    let featureFlag: FeatureFlag
}

internal enum FeatureFlag {
    case intFlag(param: Param<Int>)
    case stringFlag(param: Param<String>)
    case booleanFlag(param: Param<Bool>)
    case unknownFlag(param: Param<Any>)
}

extension FeatureFlag {
    func getKey() -> String {
        switch self {
        case .intFlag(let param):
            return param.key.value
        case .stringFlag(let param):
            return param.key.value
        case .booleanFlag(let param):
            return param.key.value
        case .unknownFlag(let param):
            return param.key.value
        }
    }
}
