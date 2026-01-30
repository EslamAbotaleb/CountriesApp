//
//  CountriesContext.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

public struct CountriesContext {
    public var networkContext: NetworkContext

    public init(
        networkContext: NetworkContext) {
        self.networkContext = networkContext
    }
}
