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
        guard var existingFlags = userDefaults.dictionary(forKey: "allflags") else { return }
        
        if existingFlags[key] != nil {
            existingFlags[key] = value
            userDefaults.set(existingFlags, forKey: "allflags")
        }
    }

    func getAll() -> Either<FBDataError, Dictionary<String, Any>> {
        guard let ffs = (userDefaults.object(forKey: "allflags") as? [String : Any]),
                !ffs.isEmpty else {
            return Either.failure(FBDataError.noDataError)
        }
        return Either.success(ffs)
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
        userDefaults.dictionaryRepresentation().keys.forEach { key in
            userDefaults.removeObject(forKey: key)
        }
    }

    private func getValue(forKey key: String) -> Any? {
        guard let flags = userDefaults.dictionary(forKey: "allflags") else { return nil }
        return flags[key]
    }
}
