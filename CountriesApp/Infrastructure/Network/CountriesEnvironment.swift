//
//  CountriesEnvironment.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

public final class CountriesEnvironment {
    public var context: CountriesContext
    private static var _shared: CountriesEnvironment?

    public static var shared: CountriesEnvironment {
        if let existing = _shared { return existing }
        let env = CountriesEnvironment()
        _shared = env
        return env
    }

    private init() {
        self.context = CountriesContext(
            networkContext: NetworkContext(baseURLString: EnvironmentApp.apiUrl)
        )
    }

    public func configure(networkContext: NetworkContext) {
        self.context.networkContext = networkContext
    }

    public static func reset() {
        _shared = nil
    }
}
