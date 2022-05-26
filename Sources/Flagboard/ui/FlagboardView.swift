//
//  File.swift
//  
//
//  Created by Christopher Ruz on 24-05-22.
//
import SwiftUI

public struct FlagboardView: View {
    public var body: some View {
        NavigationView {
            List(FlagboardInternal.getFlags()) { featureFlag in
                switch featureFlag.featureFlag {
                case .intFlag(let param):
                    Text("\(param.key.value) \(param.value)")
                case .booleanFlag(let param):
                    Text("\(param.key.value) \(param.value.description)")
                case .stringFlag(let param):
                    Text("\(param.key.value) \(param.value)")
                case .unknownFlag(let param):
                    Text("\(param.key.value)")
                }
            }
        }
    }
}
