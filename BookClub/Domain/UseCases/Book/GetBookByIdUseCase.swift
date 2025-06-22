//
//  GetBookByIdUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol GetBookByIdUseCase {
    func execute(bookId: Int) async throws -> Book
}

final class GetBookByIdUseCaseImpl: GetBookByIdUseCase {
    private let repository: BookRepository

    init(repository: BookRepository) {
        self.repository = repository
    }

    static func create() -> GetBookByIdUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = BookRepositoryImpl(httpClient: httpClient)
        return GetBookByIdUseCaseImpl(repository: repository)
    }

    func execute(bookId: Int) async throws -> Book {
        do {
            return try await repository.getBookById(bookId: bookId)
        } catch {
            throw error
        }
    }
}
