//
//  File.swift
//  
//
//  Created by Christopher Ruz on 19-05-22.
//

import Foundation
import UIKit

struct Repository {

    private let localDataSource: DataSource

    init(localDataSource: DataSource) {
        self.localDataSource = localDataSource
    }

    internal func save(featureFlag: Dictionary<String, Any>, conflictStrategy: ConflictStrategy) {
        localDataSource.save(ffs: featureFlag)
    }

    internal func getAll() -> Array<FeatureFlagS> {
        return parseToFeatureFlags(featureFlagsMap: localDataSource.getAll().getSuccessOrNull()) ?? []
    }

    internal func getRawFlags() -> Either<FBDataError, Dictionary<String, Any>> {
        return localDataSource.getAll()
    }

    internal func getInt(key: String) -> Either<FBDataError, Int> {
        return localDataSource.getIntResult(key: key)
    }

    internal func getString(key: String) -> Either<FBDataError, String> {
        return localDataSource.getStringResult(key: key)
    }

    internal func getBoolean(key: String) -> Either<FBDataError, Bool> {
        return  localDataSource.getBooleanResult(key: key)
    }

    private func parseToFeatureFlags(featureFlagsMap: Dictionary<String, Any>?) -> Array<FeatureFlagS>? {
        return featureFlagsMap?.map { entry in
            switch (entry.value) {
            case is Int:
                let ff = FeatureFlag.intFlag(param: Param(key: Key(value: entry.key), value: entry.value as! Int))
                let flag = FeatureFlagS(featureFlag: ff)
                return flag
            case is String:
                return getStringType(param: Param(key: Key(value: entry.key), value: entry.value as! String))
            case is Bool:
                let ff = FeatureFlag.booleanFlag(param: Param(key: Key(value: entry.key), value: entry.value as! Bool))
                let flag = FeatureFlagS(featureFlag: ff)
                return flag
            default:
                let ff = FeatureFlag.unknownFlag(param: Param(key: Key(value: entry.key), value: entry.value ))
                let flag = FeatureFlagS(featureFlag: ff)
                return flag
            }
        }
    }

    private func getStringType(param: Param<String>) -> FeatureFlagS {
        switch (param.value) {
        case (let value):
            if value.contains("{") {
                let ff = FeatureFlag.stringFlag(param: Param(key: Key(value: param.key.value), value: param.value ))
                let flag = FeatureFlagS(featureFlag: ff)
                return flag
            } else {
                let ff = FeatureFlag.stringFlag(param: Param(key: Key(value: param.key.value), value: param.value ))
                let flag = FeatureFlagS(featureFlag: ff)
                return flag
            }
        }
    }

    func save(key: String, value: Any) {
        localDataSource.save(key: key, value: value)
    }

    func clear(){
        localDataSource.clear()
    }
}
