//
//  ResponseProcessor.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

public protocol ResponseProcessorProtocol {
    func process<T: Decodable>(response: URLResponse?, data: Data?) async throws -> T
}

final class ResponseProcessor: ResponseProcessorProtocol {
    private let errorHandler: ErrorHandler

    init(errorHandler: ErrorHandler = ErrorHandler()) {
        self.errorHandler = errorHandler
    }
    
    func process<T: Decodable>(response: URLResponse?, data: Data?) async throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            debugPrint("❌ No valid HTTP response")
            throw NetworkError.unknown
        }
        
        debugPrint("🌐 HTTP Status Code: \(httpResponse.statusCode)")

        guard let validData = data else {
            throw NetworkError.unknown
        }

        if let rawString = String(data: validData, encoding: .utf8) {
            debugPrint("🔹 RAW RESPONSE:\n\(rawString)")
        } else {
            debugPrint("⚠️ Response data is not valid UTF-8")
        }

        // Handle HTTP errors
        if !(200..<300).contains(httpResponse.statusCode) {
            if let apiError = try? JSONDecoder().decode(ErrorResponseModel.self, from: validData) {
                debugPrint("⚠️ API Error: \(apiError.message ?? "")")
                debugPrint("Code: \(apiError.code ?? "")")
                throw NetworkError.apiError(apiError)
            } else {
                try await errorHandler.evaluate(response: httpResponse)
            }
        }

        // If caller wants raw Data
        if T.self == Data.self, let raw = validData as? T {
            return raw
        }

        do {
            let decoder = JSONDecoder()

            // Try decode wrapped BaseResponse<T> if it exists
            if let container = try? JSONSerialization.jsonObject(with: validData, options: []) as? [String: Any],
               container["data"] != nil,
               let base = try? decoder.decode(BaseResponse<T>.self, from: validData),
               let inner = base.data {
                return inner
            }

            // Otherwise, decode T directly (works for arrays or plain objects)
            return try decoder.decode(T.self, from: validData)

        } catch let decodingError as DecodingError {
            debugPrint("❌ JSON decoding failed: \(decodingError)")
            debugPrint("🔍 Response Body: \(String(data: validData, encoding: .utf8) ?? "Unreadable data")")
            try await errorHandler.handleDecodingError(error: decodingError)
        } catch {
            debugPrint("❌ Unexpected error while decoding: \(error.localizedDescription)")
            throw NetworkError.unknown
        }
    }
}
