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
    case addToFavorites
    case removeFromFavorites(documentId: String)
    case getFavoritesByBookId(bookId: Int)

    var path: String {
        switch self {
        case .getFavorites:
            return "/favorites"
        case .addToFavorites:
            return "/favorites"
        case .removeFromFavorites(let documentId):
            return "/favorites/\(documentId)"
        case .getFavoritesByBookId(let bookId):
            return "/favorites?filters[bookId][$eq]=\(bookId)"
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
        case.getFavoritesByBookId:
            return .get
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
