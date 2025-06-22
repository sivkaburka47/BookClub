//
//  GetBookChaptersUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol GetBookChaptersUseCase {
    func execute(bookId: Int) async throws -> [Chapter]
}

final class GetBookChaptersUseCaseImpl: GetBookChaptersUseCase {
    private let repository: BookRepository

    init(repository: BookRepository) {
        self.repository = repository
    }

    static func create() -> GetBookChaptersUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = BookRepositoryImpl(httpClient: httpClient)
        return GetBookChaptersUseCaseImpl(repository: repository)
    }

    func execute(bookId: Int) async throws -> [Chapter] {
        do {
            return try await repository.getBookChapters(bookId: bookId)
        } catch {
            throw error
        }
    }
}
