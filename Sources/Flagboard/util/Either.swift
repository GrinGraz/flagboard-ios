//
//  File.swift
//  
//
//  Created by Christopher Ruz on 19-05-22.
//

import Foundation

public enum Either<Error, Success> {
    case failure(Error)
    case success(Success)

    func map<E>(
        _ transform: (Error) -> E
    ) -> Either<E, Success> {
        switch self {
        case .failure(let value):
            return .failure(transform(value))
        case .success(let value):
            return .success(value)
        }
    }

    func map<S>(
        _ transform: (Success) -> S
    ) -> Either<Error, S> {
        switch self {
        case .success(let value):
            return .success(transform(value))
        case .failure(let value):
            return .failure(value)
        }
    }

    func bimap<E, S> (
        _ transformError: (_ error: Error) -> E,
        _ transformSuccess: (_ success: Success) -> S
    ) -> Either<E, S> {
        fold({ .failure(transformError($0)) }, { .success(transformSuccess($0)) })
    }

    func getSuccessOrNull() -> Success? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

    func fold<Value>(
        _ onError: (Error) -> Value,
        _ onSuccess: (Success) -> Value
    ) -> Value {
        switch self {
        case .failure(let error):
            return onError(error)
        case .success(let success):
            return onSuccess(success)
        }
    }
}
