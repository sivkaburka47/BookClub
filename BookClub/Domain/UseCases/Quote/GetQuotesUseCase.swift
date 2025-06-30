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
    private let bookRepository: BookRepository

    init(repository: QuoteRepository, bookRepository: BookRepository) {
        self.repository = repository
        self.bookRepository = bookRepository
    }

    static func create() -> GetQuotesUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = QuoteRepositoryImpl(httpClient: httpClient)
        let bookRepository = BookRepositoryImpl(httpClient: httpClient)

        return GetQuotesUseCaseImpl(repository: repository, bookRepository: bookRepository)
    }

    func execute() async throws -> [Quote] {
        let quotes = try await repository.getQuotes()

        return try await withThrowingTaskGroup(of: Quote?.self) { group in
            for quote in quotes {
                group.addTask {
                    do {
                        let book = try await self.bookRepository.getBookById(bookId: quote.bookId)
                        var enrichedQuote = quote
                        enrichedQuote.bookTitle = book.title
                        enrichedQuote.authors = book.authors
                        return enrichedQuote
                    } catch {
                        return nil
                    }
                }
            }

            var result: [Quote] = []
            for try await enriched in group {
                if let enriched = enriched {
                    result.append(enriched)
                }
            }

            return result
        }
    }


    func getBookInfo(bookId: Int) async throws -> Book {
        do {
            return try await bookRepository.getBookById(bookId: bookId)
        } catch {
            throw error
        }
    }

}
