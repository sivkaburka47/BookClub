//
//  AuthEndpoint.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation
import Alamofire

enum AuthEndpoint: APIEndpoint {
    case register
    case login

    var path: String {
        switch self {
        case .register:
            return "/auth/local/register"
        case .login:
            return "/auth/local"
        }
    }

    var method: HTTPMethod { .post }
    var parameters: Parameters? { nil }
    var headers: HTTPHeaders? {
        ["Content-Type": "application/json"]
    }
}
