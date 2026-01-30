//
//  BaseResponseProtocol.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

protocol BaseResponseProtocol: Decodable {
    var statusCode: Int? { get }
    var code: String? { get }
    var message: String? { get }
}

