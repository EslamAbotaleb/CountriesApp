//
//  BaseResponse.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

struct BaseResponse<T: Decodable>: BaseResponseProtocol {
    let statusCode: Int?
    let code: String?
    let message: String?
    let data: T?

    enum CodingKeys: String, CodingKey {
        case statusCode
        case status
        case code
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        statusCode = (try? container.decode(Int.self, forKey: .statusCode))
        code = try? container.decode(String.self, forKey: .code)
        message = try? container.decode(String.self, forKey: .message)
        data = try? container.decode(T.self, forKey: .data)
    }
}
