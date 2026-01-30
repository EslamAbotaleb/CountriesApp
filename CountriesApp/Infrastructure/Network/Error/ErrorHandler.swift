//
//  ErrorHandler.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

public protocol ErrorHandlerProtocol {
    func evaluate(response: HTTPURLResponse?) async throws
    func handleDecodingError(error: DecodingError) async throws -> Never
}

public struct ErrorHandler: ErrorHandlerProtocol {

    public func evaluate(response: HTTPURLResponse?) async throws {
        guard let response = response else {
            throw NetworkError.unknown
        }

        switch response.statusCode {
        case 401:
            throw NetworkError.unauthorized
        case 404:
            throw NetworkError.notFound
        case 500..<600:
            throw NetworkError.serverError(response.statusCode)
        default:
            return
        }
    }
    
    public func handleDecodingError(error: DecodingError) async throws -> Never {
        switch error {
        case .typeMismatch(let type, let context):
            log("Type mismatch for \(type) at path: \(context.codingPath.map(\.stringValue).joined(separator: ".")), description: \(context.debugDescription)")
            throw NetworkError.decodingError(.typeMismatch(
                expected: "\(type)",
                found: "Unexpected type",
                path: context.codingPath.map(\.stringValue).joined(separator: ".")
            ))

        case .valueNotFound(let type, let context):
            log("Value not found for \(type) at path: \(context.codingPath.map(\.stringValue).joined(separator: ".")), description: \(context.debugDescription)")
            throw NetworkError.decodingError(.valueNotFound(
                type: "\(type)",
                path: context.codingPath.map(\.stringValue).joined(separator: ".")
            ))

        case .keyNotFound(let key, let context):
            log("Key '\(key.stringValue)' not found at path: \(context.codingPath.map(\.stringValue).joined(separator: ".")), description: \(context.debugDescription)")
            throw NetworkError.decodingError(.keyNotFound(
                key: key.stringValue,
                path: context.codingPath.map(\.stringValue).joined(separator: ".")
            ))

        case .dataCorrupted(let context):
            log("Data corrupted at path: \(context.codingPath.map(\.stringValue).joined(separator: ".")), reason: \(context.debugDescription)")
            throw NetworkError.decodingError(.dataCorrupted(reason: context.debugDescription))

        @unknown default:
            log("Unknown decoding error: \(error.localizedDescription)")
            throw NetworkError.decodingError(.unknown(reason: error.localizedDescription))
        }
    }
    
    func log(_ message: String) {
        debugPrint("❌ [DecodingError] \(message)")
    }
}
