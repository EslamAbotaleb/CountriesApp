//
//  ErrorResponseModel.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

public struct ErrorResponseModel: BaseResponseProtocol {
    var statusCode: Int?
    var code: String?
    var message: String?
}
