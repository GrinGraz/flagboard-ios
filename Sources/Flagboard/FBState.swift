//
//  File.swift
//  
//
//  Created by Christopher Ruz on 19-05-22.
//

import Foundation

public enum FBState {
    case unknown
    case initialized(dataState: FBDataState)
}
