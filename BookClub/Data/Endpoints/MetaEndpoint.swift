//
//  MetaEndpoint.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation
import Alamofire

enum MetaEndpoint: APIEndpoint {
    case getAuthors
    case getGenres

    var path: String {
        switch self {
        case .getAuthors:
            return "/Authors"
        case .getGenres:
            return "/Genres"
        }
    }

    var method: HTTPMethod { .get }
    var parameters: Parameters? { nil }
    var headers: HTTPHeaders? { nil }
}
