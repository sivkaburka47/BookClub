//
//  CreateQuoteUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol CreateQuoteUseCase {
    func execute(quote: Quote) async throws
}

final class CreateQuoteUseCaseImpl: CreateQuoteUseCase {
    private let repository: QuoteRepository

    init(repository: QuoteRepository) {
        self.repository = repository
    }

    static func create() -> CreateQuoteUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = QuoteRepositoryImpl(httpClient: httpClient)
        return CreateQuoteUseCaseImpl(repository: repository)
    }

    func execute(quote: Quote) async throws {
        do {
            try await repository.createQuote(quote: quote)
        } catch {
            throw error
        }
    }
}
