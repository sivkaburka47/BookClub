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

    var method: Alamofire.HTTPMethod { .post }
    var parameters: Alamofire.Parameters? { nil }
    var headers: Alamofire.HTTPHeaders? {
        ["Content-Type": "application/json"]
    }
}
