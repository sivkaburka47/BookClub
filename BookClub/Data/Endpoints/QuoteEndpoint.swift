//
//  QuoteEndpoint.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation
import Alamofire
import KeychainAccess

enum QuoteEndpoint: APIEndpoint {
    case getQuotes
    case createQuote

    var path: String {
        switch self {
        case .getQuotes:
            return "/quotes"
        case .createQuote:
            return "/quotes"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .getQuotes:
            return .get
        case .createQuote:
            return .post
        }
    }

    var parameters: Alamofire.Parameters? { nil }

    var headers: Alamofire.HTTPHeaders? {
        guard let token = authToken else { return nil }
        return ["Authorization": "Bearer \(token)"]
    }

    private var authToken: String? {
        let keychain = Keychain()
        return try? keychain.get("authToken")
    }
}
