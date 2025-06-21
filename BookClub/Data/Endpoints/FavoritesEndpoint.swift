//
//  FavoritesEndpoint.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation
import Alamofire
import KeychainAccess

enum FavoritesEndpoint: APIEndpoint {
    case getFavorites
    case addToFavorites(bookId: Int)
    case removeFromFavorites(documentId: String)

    var path: String {
        switch self {
        case .getFavorites:
            return "/favorites"
        case .addToFavorites:
            return "/favorites"
        case .removeFromFavorites(let documentId):
            return "/favorites/\(documentId)"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .getFavorites:
            return .get
        case .addToFavorites:
            return .post
        case .removeFromFavorites:
            return .delete
        }
    }

    var parameters: Alamofire.Parameters? {
        return nil
    }

    var headers: Alamofire.HTTPHeaders? {
        guard let token = authToken else { return nil }
        return ["Authorization": "Bearer \(token)"]
    }

    private var authToken: String? {
        let keychain = Keychain()
        return try? keychain.get("authToken")
    }
}
