//
//  FlagboardContainer.swift
//  
//
//  Created by Christopher Ruz on 16-05-22.
//

import Foundation

internal struct FlagboardContainer {
    internal let repository = Repository(localDataSource: LocalDataSource(userDefault: UserDefaults.standard))
}
