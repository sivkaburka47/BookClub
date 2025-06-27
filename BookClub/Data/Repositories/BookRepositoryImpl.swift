//
//  BookRepositoryImpl.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

import Foundation

final class BookRepositoryImpl {

    enum BookRepositoryError: LocalizedError {
        case bookNotFound(bookId: Int)

        var errorDescription: String? {
            switch self {
            case .bookNotFound(let id):
                return "Книга с ID \(id) не найдена."
            }
        }
    }

    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

}

extension BookRepositoryImpl: BookRepository {

    func getBooks(page: Int?, pageSize: Int?) async throws -> [Book] {
        let endpoint = BookEndpoint.getBooks(page: page ?? 1, pageSize: pageSize ?? 1000)
        let response: BooksResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)
        return response.data.map { $0.toDomain() }
    }

    func getBookById(bookId: Int) async throws -> Book {
        let endpoint = BookEndpoint.getBookById(bookId: bookId)
        let response: BooksResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)

        guard let dto = response.data.first else {
            throw BookRepositoryError.bookNotFound(bookId: bookId)
        }

        return dto.toDomain()
    }

    func findBooksByName(name: String) async throws -> [Book] {
        let endpoint = BookEndpoint.findBooksByName(name: name)
        let response: BooksResponseWithoutAuthorsDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)

        return response.data.map { $0.toDomain() }
    }

    func getBooksByGenre(genre: Int) async throws -> [Book] {
        let endpoint = BookEndpoint.getBooksByGenre(genre: genre)
        let response: BooksResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)

        return response.data.map { $0.toDomain() }
    }

    func getBooksByAuthor(author: Int) async throws -> [Book] {
        let endpoint = BookEndpoint.getBooksByAuthor(author: author)
        let response: BooksResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)

        return response.data.map { $0.toDomain() }
    }

    func getNewBooks() async throws -> [Book] {
        let endpoint = BookEndpoint.getNewBooks
        let response: BooksResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)
        return response.data.map { $0.toDomain() }
    }

    func getBookChapters(bookId: Int) async throws -> [Chapter] {
        let endpoint = BookEndpoint.getBookChapters(bookId: bookId)
        let response: ChapterResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)
        return response.data.map { $0.toDomain() }
    }

    func getChapterWithBook(chapterId: Int) async throws -> ReadingStatus? {
        let endpoint = BookEndpoint.getChapterWithBook(chapterId: chapterId)
        let response: ChapterWithBookResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)
        return response.data.first?.toReadingStatus()
    }
}
