//
//  BookEndpoint.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation
import Alamofire
import KeychainAccess

enum BookEndpoint: APIEndpoint {
    case getBooks(page: Int = 1, pageSize: Int = 1000)
    case getBookById(bookId: Int)
    case findBooksByName(name: String)
    case getBooksByGenre(genre: String)
    case getBooksByAuthor(author: String)
    case getNewBooks
    case getBookChapters(bookId: Int)

    var path: String {
        switch self {
        case .getBooks(let page, let pageSize):
            return "/books?pagination[page]=\(page)&pagination[pageSize]=\(pageSize)"
        case .getBookById(let bookId):
            return "/books?filters[id]=\(bookId)"
        case .findBooksByName(let name):
            return "/books?filters[title][$containsi]=\(name)"
        case .getBooksByGenre(let genre):
            return "/books?filters[genres][id][$eq]=\(genre)"
        case .getBooksByAuthor(let author):
            return "/books?filters[authors][id][$eq]=\(author)"
        case .getNewBooks:
            return "/books?filters[isNew]=true"
        case .getBookChapters(let bookId):
            return "/chapters?filters[book][id][$eq]=\(bookId)"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var parameters: Parameters? {
        return nil
    }

    var headers: HTTPHeaders? {
        guard let token = authToken else { return nil }
        return ["Authorization": "Bearer \(token)"]
    }

    private var authToken: String? {
        let keychain = Keychain()
        return try? keychain.get("authToken")
    }
}
