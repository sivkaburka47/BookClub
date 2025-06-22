//
//  GetQuotesUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol GetQuotesUseCase {
    func execute() async throws -> [Quote]
}

final class GetQuotesUseCaseImpl: GetQuotesUseCase {
    private let repository: QuoteRepository

    init(repository: QuoteRepository) {
        self.repository = repository
    }

    static func create() -> GetQuotesUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = QuoteRepositoryImpl(httpClient: httpClient)
        return GetQuotesUseCaseImpl(repository: repository)
    }

    func execute() async throws -> [Quote]{
        do {
            return try await repository.getQuotes()
        } catch {
            throw error
        }
    }
}
