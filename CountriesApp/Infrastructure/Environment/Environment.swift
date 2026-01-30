//
//  Environment.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

public enum EnvironmentApp {
    
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let API_Base_URL = "API_Base_URL"
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    static let apiUrl: String = {
        guard let apiKey = EnvironmentApp.infoDictionary[Keys.Plist.API_Base_URL] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return apiKey
    }()
}
