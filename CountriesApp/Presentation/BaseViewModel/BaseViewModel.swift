//
//  BaseViewModel.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

protocol BaseViewModel: ObservableObject {
    var isLoading: Bool { get set }
    var errorMessage: String? { get set }
}

@MainActor
extension BaseViewModel {
    func perform<T>(
        action: @escaping () async throws -> T,
        assignTo published: @escaping (T) -> Void) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await action()
            published(response)
        } catch let networkError as NetworkError {
            switch networkError {
            case .apiError(let apiError):
                errorMessage = apiError.message
            default:
                errorMessage = networkError.localizedDescription
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
