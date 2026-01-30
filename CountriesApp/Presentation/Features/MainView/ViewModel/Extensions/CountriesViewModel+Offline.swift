//
//  CountriesViewModel+Offline.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

extension CountriesViewModel {
    
    // Save selected countries to UserDefaults
    func saveSelectedCountries() {
        if let data = try? JSONEncoder().encode(selectedCountries) { UserDefaults.standard.set(data, forKey: selectedCountriesKey)
        }
    }
    
    // load saved countries
    func loadSavedOrDefaultCountries() {
        if let data = UserDefaults.standard.data(forKey: selectedCountriesKey),
           let savedCountries = try? JSONDecoder().decode([CountryDTO].self, from: data),
           !savedCountries.isEmpty {
            selectedCountries = savedCountries
            return
        }
        
        // nothing saved, set default from location
        trySetDefaultCountry()
    }
    
}
