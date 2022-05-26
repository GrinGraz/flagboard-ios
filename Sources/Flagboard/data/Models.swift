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
