//
//  GetBookCardsUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 27.06.2025.
//

protocol GetBookCardsUseCase {
    func execute() async throws -> [BookGridCard]
}

final class GetBookCardsUseCaseImpl: GetBookCardsUseCase {
    private let repository: BookRepository

    init(repository: BookRepository) {
        self.repository = repository
    }

    static func create() -> GetBookCardsUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = BookRepositoryImpl(httpClient: httpClient)
        return GetBookCardsUseCaseImpl(repository: repository)
    }

    func execute() async throws -> [BookGridCard] {
        do {
            return try await repository.getBooks(page: nil, pageSize: nil).map { $0.toBookGridCard() }
        } catch {
            throw error
        }
    }
}
