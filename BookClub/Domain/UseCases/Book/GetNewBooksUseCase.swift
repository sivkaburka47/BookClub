//
//  GetNewBooksUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol GetNewBooksUseCase {
    func execute() async throws -> [FeaturedBookCard]
}

final class GetNewBooksUseCaseImpl: GetNewBooksUseCase {
    private let repository: BookRepository

    init(repository: BookRepository) {
        self.repository = repository
    }

    static func create() -> GetNewBooksUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = BookRepositoryImpl(httpClient: httpClient)
        return GetNewBooksUseCaseImpl(repository: repository)
    }

    func execute() async throws -> [FeaturedBookCard] {
        do {
            return try await repository.getNewBooks().map { $0.toFeaturedBookCard() }
        } catch {
            throw error
        }
    }
}
