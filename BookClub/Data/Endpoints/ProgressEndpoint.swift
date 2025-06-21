//
//  ProgressEndpoint.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation
import Alamofire

enum ProgressEndpoint: APIEndpoint {
    case getProgress
    case saveProgress(bookId: UUID, chapter: Int)
    case updateProgress(bookId: UUID, chapter: Int)

    var path: String {
        switch self {
        case .getProgress:
            return "/Progress"
        case .saveProgress:
            return "/Progress"
        case .updateProgress:
            return "/Progress"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getProgress:
            return .get
        case .saveProgress:
            return .post
        case .updateProgress:
            return .put
        }
    }

    var parameters: Parameters? {
        switch self {
        case .saveProgress(let bookId, let chapter),
             .updateProgress(let bookId, let chapter):
            return [
                "bookId": bookId.uuidString,
                "chapter": chapter
            ]
        default:
            return nil
        }
    }

    var headers: HTTPHeaders? { nil }
}
