//
//  File.swift
//  
//
//  Created by Andy Torres on 25-06-24.
//

import Foundation

private class BundleFinder {}

extension Bundle {
    /// Returns the resource bundle associated with the current Swift module.
    static var current: Bundle = {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        // This is your `target.path` (located in your `Package.swift`) by replacing all the `/` by the `_`.
        let bundleName = "AAA_BBB"
        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,
            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: BundleFinder.self).resourceURL,
            // For command-line tools.
            Bundle.main.bundleURL,
        ]
        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        
        return Bundle(for: BundleFinder.self)
        #endif
    }()

    public static let ds: Bundle = .current
}
