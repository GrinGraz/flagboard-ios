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
        ffs.forEach { key, value in
            save(key: key, value: value)
        }
    }

    func save(key: String, value: Any) {
        var existingFlags = userDefaults.dictionary(forKey: "allflags") ?? [:]
        existingFlags[key] = value
        userDefaults.set(existingFlags, forKey: "allflags")
    }

    func getAll() -> Either<FBDataError, Dictionary<String, Any>> {
        guard let ffs = (userDefaults.object(forKey: "allflags") as? [String : Any]),
                !ffs.isEmpty else {
            return Either.failure(FBDataError.noDataError)
        }
        
        let castedFlags: [String: Any] = ffs.mapValues { value in
            if let boolValue = value as? Bool {
                return boolValue
            }
            
            if let stringValue = value as? String {
                return stringValue
            }
            
            if let intValue = value as? Int {
                return intValue
            }
            
            if let jsonValue = value as? [String: Any] {
                return jsonValue
            }
            
            return value
        }
        
        return Either.success(castedFlags)
    }

    func getIntResult(key: String) -> Either<FBDataError, Int> {
        guard let value = getValue(forKey: key) as? Int
        else {
            return .failure(.keyNotExistError)
        }

        return .success(value)
    }

    func getStringResult(key: String) -> Either<FBDataError, String> {
        guard let value = getValue(forKey: key) as? String
        else {
            return .failure(.keyNotExistError)
        }

        return .success(value)
    }

    func getBooleanResult(key: String) -> Either<FBDataError, Bool> {
        guard let value = getValue(forKey: key) as? Bool
        else {
            return .failure(.keyNotExistError)
        }

        return .success(value)
    }

    func clear() {
        userDefaults.removeObject(forKey: "allflags")
    }

    private func getValue(forKey key: String) -> Any? {
        guard let flags = userDefaults.dictionary(forKey: "allflags") else { return nil }
        return flags[key]
    }
}
