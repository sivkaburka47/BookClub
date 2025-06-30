//
//  MetaEndpoint.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation
import Alamofire
import KeychainAccess

enum MetaEndpoint: APIEndpoint {
    case getAuthors
    case getGenres

    var path: String {
        switch self {
        case .getAuthors:
            return "/authors"
        case .getGenres:
            return "/genres"
        }
    }

    var method: Alamofire.HTTPMethod { .get }
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
