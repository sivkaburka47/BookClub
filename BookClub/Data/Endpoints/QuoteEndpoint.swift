//
//  QuoteEndpoint.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation
import Alamofire

enum QuoteEndpoint: APIEndpoint {
    case getQuotes
    case createQuote(text: String)

    var path: String {
        switch self {
        case .getQuotes:
            return "/Quotes"
        case .createQuote:
            return "/Quotes"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getQuotes:
            return .get
        case .createQuote:
            return .post
        }
    }

    var parameters: Parameters? {
        switch self {
        case .createQuote(let text):
            return ["text": text]
        default:
            return nil
        }
    }

    var headers: HTTPHeaders? { nil }
}
