//
//  CRUDCountryViewModelExtension.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import CoreLocation

extension CountriesViewModel {
    // Add / Remove Countries
    func addCountry(_ country: CountryDTO) {
        guard selectedCountries.count < 5 else { return }
        guard !selectedCountries.contains(where: { $0.name == country.name }) else { return }
        selectedCountries.append(country)
        saveSelectedCountries()
    }
    
    func removeCountry(_ country: CountryDTO) {
        selectedCountries.removeAll { $0.id == country.id }
        saveSelectedCountries()
    }
    
    // set default country
    func trySetDefaultCountry() {
        // Only set default if countries loaded and nothing selected
        guard !allCountries.isEmpty, selectedCountries.isEmpty else { return }
        
        if let code = locationCountryCode,
           let country = allCountries.first(where: { $0.name.lowercased().contains(code.lowercased()) }) {
            selectedCountries.append(country)
        } else if CLLocationManager().authorizationStatus != .notDetermined {
            // Only add Egypt if user denied location
            addEgyptAsDefaultCountry()
        }
    }
    
    func addEgyptAsDefaultCountry() {
        if let egypt = allCountries.first(where: { $0.name.lowercased() == "egypt" }) {
            selectedCountries.append(egypt)
        }
    }
    
   func setDefaultAfterCountriesLoaded() {
        guard selectedCountries.isEmpty else { return }
        
        let status = CLLocationManager().authorizationStatus
        
        switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                if let code = locationCountryCode,
                   let country = allCountries.first(where: {
                       $0.name.lowercased().contains(code.lowercased())
                   }) {
                    selectedCountries.append(country)
                }
            case .denied, .restricted:
                // User denied location → show Egypt
                addEgyptAsDefaultCountry()
            case .notDetermined:
                // Permission not asked yet → do nothing
                break
            @unknown default:
                break
        }
    }
}
