//
//  NetworkError.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case connectionFailed
    case unauthorized
    case serverError(Int)
    case decodingError(DecodingErrorDetail)
    case unknown
    case needsRetry
    case badRequest(String)
    case notFound
    case rateLimitExceeded
    case invalidURL
    case apiError(ErrorResponseModel)

    public var errorDescription: String? {
        switch self {
            case .connectionFailed:
                return "No internet connection"
            case .unauthorized:
                return "Authentication required"
            case .serverError(let code):
                return "Server error: \(code)"
            case .decodingError(let detail):
                return "Decoding error: \(detail)"
            case .unknown:
                return "An unexpected error occurred"
            case .needsRetry:
                return "Operation needs retry"
            case .badRequest(let message):
                return "Bad request: \(message)"
            case .notFound:
                return "Resource not found"
            case .rateLimitExceeded:
                return "Too many requests. Please try again later"
            case .invalidURL:
                return "Invalid URL provided"
            case .apiError(let apiError):
                return apiError.message
        }
    }
}

public enum DecodingErrorDetail {
    case typeMismatch(expected: String, found: String, path: String)
    case valueNotFound(type: String, path: String)
    case keyNotFound(key: String, path: String)
    case dataCorrupted(reason: String)
    case unknown(reason: String)
}


extension DecodingErrorDetail {

    var localizedDescription: String {
        switch self {
        case .typeMismatch(let expected, let found, let path):
            return "Expected type '\(expected)', but found '\(found)' at '\(path)'."
        case .valueNotFound(let type, let path):
            return "Missing value for type '\(type)' at '\(path)'."
        case .keyNotFound(let key, let path):
            return "Missing key '\(key)' at '\(path)'."
        case .dataCorrupted(let reason):
            return "Data corrupted: \(reason)"
        case .unknown(let reason):
            return "Unknown decoding error: \(reason)"
        }
    }
}
