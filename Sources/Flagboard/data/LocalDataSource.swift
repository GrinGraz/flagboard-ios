//
//  File.swift
//  
//
//  Created by Christopher Ruz on 16-05-22.
//

import Foundation

internal struct LocalDataSource: DataSource {

    let userDefaults: UserDefaults

    internal init(userDefault: UserDefaults) {
        self.userDefaults = userDefault
    }

    func save(ffs: Dictionary<String, Any>) {
        userDefaults.set(ffs, forKey: "allflags")
        ffs.forEach { key, value in
            save(key: key, value: value)
        }
    }

    func save(key: String, value: Any) {
//        switch value {
//
//        }
        userDefaults.setValue(value, forKey: key)
    }

    func getAll() -> Either<FBDataError, Dictionary<String, Any>> {
        guard let ffs = (userDefaults.object(forKey: "allflags") as? [String : Any]),
                !ffs.isEmpty else {
            return Either.failure(FBDataError.noDataError)
        }
        let parsedMap = ffs.mapValues { value in
            var booleanValue = false
            var isABool = false
            ffs.forEach { key, value2 in
                if key.contains("Bool") {
                    booleanValue = value as! Int == 0
                    isABool = !isABool
                }
            }
            if isABool {
                return booleanValue
            } else {
                return value as Any
            }
        }
        return Either.success(parsedMap)
    }

    func getIntResult(key: String) -> Either<FBDataError, Int> {
        return safeGetValue(key: key) {
            userDefaults.integer(forKey: key)
        }
    }

    func getStringResult(key: String) -> Either<FBDataError, String> {
        return safeGetValue(key: key) {
            userDefaults.string(forKey: key)!
        }
    }

    func getBooleanResult(key: String) -> Either<FBDataError, Bool> {
        return safeGetValue(key: key) {
            userDefaults.bool(forKey: key)
        }
    }

    func clear() {
        userDefaults.dictionaryRepresentation().keys.forEach { key in
            userDefaults.removeObject(forKey: key)
        }
    }

    private func safeGetValue<T>(key: String, block: () -> T) -> Either<FBDataError, T> {
        if (userDefaults.object(forKey: key) != nil) {
            return tryGetValue(block)
        } else {
            return Either.failure(.keyNotExistError)
        }
    }

    private func tryGetValue<T>(_ block: () throws -> T?) -> Either<FBDataError, T> {
        do {
            if try block() == nil {
                return Either.failure(.noDataError)
            }
            return try Either.success(block()!)
        } catch {
            return Either.failure(.wrongTypeError)
        }
    }
}
