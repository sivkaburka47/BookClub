//
//  BookEndpoint.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation
import Alamofire

enum BookEndpoint: APIEndpoint {
    case getBooks
    case getBookById(id: UUID)
    case findBooksByName(name: String)
    case getBooksByGenre(genre: String)
    case getBooksByAuthor(author: String)
    case getNewBooks
    case getBookChapters(bookId: UUID)

    var path: String {
        switch self {
        case .getBooks:
            return "/Books"
        case .getBookById(let id):
            return "/Books/\(id.uuidString)"
        case .findBooksByName:
            return "/Books/Search"
        case .getBooksByGenre:
            return "/Books/Genre"
        case .getBooksByAuthor:
            return "/Books/Author"
        case .getNewBooks:
            return "/Books/New"
        case .getBookChapters(let bookId):
            return "/Books/\(bookId.uuidString)/Chapters"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var parameters: Parameters? {
        switch self {
        case .findBooksByName(let name):
            return ["name": name]
        case .getBooksByGenre(let genre):
            return ["genre": genre]
        case .getBooksByAuthor(let author):
            return ["author": author]
        default:
            return nil
        }
    }

    var headers: HTTPHeaders? { nil }
}
