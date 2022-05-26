//
//  File.swift
//  
//
//  Created by Christopher Ruz on 16-05-22.
//

import Foundation

internal protocol DataSource {
    func save(ffs: Dictionary<String, Any>)
    func save(key: String, value: Any)
    func getAll() -> Either<FBDataError, Dictionary<String, Any>>
    func getIntResult(key: String) -> Either<FBDataError, Int>
    func getStringResult(key: String) -> Either<FBDataError, String>
    func getBooleanResult(key: String) -> Either<FBDataError, Bool>
    func clear()
}
