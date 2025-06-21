//
//  FavoritesEndpoint.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation
import Alamofire

enum FavoritesEndpoint: APIEndpoint {
    case getFavorites
    case addToFavorites(bookId: UUID)
    case removeFromFavorites(bookId: UUID)

    var path: String {
        switch self {
        case .getFavorites:
            return "/Favorites"
        case .addToFavorites:
            return "/Favorites"
        case .removeFromFavorites(let bookId):
            return "/Favorites/\(bookId.uuidString)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getFavorites:
            return .get
        case .addToFavorites:
            return .post
        case .removeFromFavorites:
            return .delete
        }
    }

    var parameters: Parameters? {
        switch self {
        case .addToFavorites(let bookId):
            return ["bookId": bookId.uuidString]
        default:
            return nil
        }
    }

    var headers: HTTPHeaders? { nil }
}
