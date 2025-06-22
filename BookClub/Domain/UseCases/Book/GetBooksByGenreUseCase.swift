//
//  GetBooksByGenreUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol GetBooksByGenreUseCase {
    func execute(genre: Int) async throws -> [Book]
}

final class GetBooksByGenreUseCaseImpl: GetBooksByGenreUseCase {
    private let repository: BookRepository

    init(repository: BookRepository) {
        self.repository = repository
    }

    static func create() -> GetBooksByGenreUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = BookRepositoryImpl(httpClient: httpClient)
        return GetBooksByGenreUseCaseImpl(repository: repository)
    }

    func execute(genre: Int) async throws -> [Book] {
        do {
            return try await repository.getBooksByGenre(genre: genre)
        } catch {
            throw error
        }
    }
}
