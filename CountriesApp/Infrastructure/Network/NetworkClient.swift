//
//  NetworkClient.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

protocol NetworkProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class NetworkClient: NetworkProtocol {
    private let network: NetworkServiceProtocol
    private let interceptor: InterceptorChainProtocol
    private let responseProcessor: ResponseProcessorProtocol
    private let context: CountriesContext

    init(
        context: CountriesContext,
        network: NetworkServiceProtocol = NetworkService(),
        requestModifiers: [RequestModifier] = [
            AuthorizationModifier(),
            LanguageModifier()
        ],
        responseProcessor: ResponseProcessorProtocol = ResponseProcessor()) {
        self.context = context
        self.network = network
        self.interceptor = InterceptorChain(modifiers: requestModifiers, context: context)
        self.responseProcessor = responseProcessor
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        // Build request with context’s base URL
        var request = RequestBuilder.makeRequest(from: endpoint, baseURL: context.networkContext.baseURL)

        // Apply request modifiers (authorization, language, etc.)
        request = await interceptor.modify(request: request)
        logRequest(request)
        
        // Perform network request
        let (data, response) = try await network.sendRequest(request)
        logResponse(response, data: data)
        
        // Process and decode response
        return try await responseProcessor.process(response: response, data: data)
    }
    
    // MARK: - Logging Helpers
    private func logRequest(_ request: URLRequest) {
        debugPrint("➡️ [Request] \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        debugPrint("Headers: \(request.allHTTPHeaderFields ?? [:])")
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            debugPrint("Body: \(bodyString)")
        }
    }

    private func logResponse(_ response: URLResponse?, data: Data?) {
        if let httpResponse = response as? HTTPURLResponse {
            debugPrint("⬅️ [Response] \(httpResponse.statusCode) \(httpResponse.url?.absoluteString ?? "")")
            debugPrint("Headers: \(httpResponse.allHeaderFields)")
        }
        if let data = data, let responseBody = String(data: data, encoding: .utf8) {
            debugPrint("Response Body: \(responseBody)")
        }
    }
}
