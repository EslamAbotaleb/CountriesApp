//
//  ContentView.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import SwiftUI

struct ContentView: View {
    // For debugging
    private let apiUrl = CountriesEnvironment.shared.context.networkContext.baseURLString

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello, world!")

            // Show API URL for debugging
            Text("API URL: \(apiUrl)")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
