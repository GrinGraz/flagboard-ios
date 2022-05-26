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

class FeatureFlagS: Identifiable {
    var id: ObjectIdentifier

    let featureFlag: FeatureFlag

    internal init(id: ObjectIdentifier = ObjectIdentifier(FeatureFlag.self), featureFlag: FeatureFlag) {
        self.id = id
        self.featureFlag = featureFlag
    }

}

internal enum FeatureFlag {
    case intFlag(param: Param<Int>)
    case stringFlag(param: Param<String>)
    case booleanFlag(param: Param<Bool>)
    case unknownFlag(param: Param<Any>)
}
