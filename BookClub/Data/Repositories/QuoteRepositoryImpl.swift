//
//  QuoteRepositoryImpl.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

final class QuoteRepositoryImpl {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
}

extension QuoteRepositoryImpl: QuoteRepository {
    func getQuotes() async throws -> [Quote] {
        let endpoint = QuoteEndpoint.getQuotes
        let response: QuotesResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)

        return response.data.map { $0.toDomain() }
    }

    func createQuote(quote: Quote) async throws {
        let endpoint = QuoteEndpoint.createQuote
        let request: AddToQuotesRequestDTO = AddToQuotesRequestDTO(data: .init(text: quote.text, bookId: quote.bookId))

        try await httpClient.sendRequestWithoutResponse(endpoint: endpoint, requestBody: request)
    }
}
