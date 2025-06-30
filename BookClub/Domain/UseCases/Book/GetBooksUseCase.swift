//
//  GetBooksUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol GetBooksUseCase {
    func execute(page: Int?, pageSize: Int?) async throws -> [Book]
}

final class GetBooksUseCaseImpl: GetBooksUseCase {
    private let repository: BookRepository

    init(repository: BookRepository) {
        self.repository = repository
    }

    static func create() -> GetBooksUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = BookRepositoryImpl(httpClient: httpClient)
        return GetBooksUseCaseImpl(repository: repository)
    }

    func execute(page: Int?, pageSize: Int?) async throws -> [Book] {
        do {
            return try await repository.getBooks(page: page, pageSize: pageSize)
        } catch {
            throw error
        }
    }
}
