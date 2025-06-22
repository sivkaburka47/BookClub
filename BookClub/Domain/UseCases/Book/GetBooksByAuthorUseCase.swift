//
//  GetBooksByAuthorUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol GetBooksByAuthorUseCase {
    func execute(author: Int) async throws -> [Book]
}

final class GetBooksByAuthorUseCaseImpl: GetBooksByAuthorUseCase {
    private let repository: BookRepository

    init(repository: BookRepository) {
        self.repository = repository
    }

    static func create() -> GetBooksByAuthorUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = BookRepositoryImpl(httpClient: httpClient)
        return GetBooksByAuthorUseCaseImpl(repository: repository)
    }

    func execute(author: Int) async throws -> [Book] {
        do {
            return try await repository.getBooksByAuthor(author: author)
        } catch {
            throw error
        }
    }
}
