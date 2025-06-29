//
//  FavoritesRepositoryImpl.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

final class FavoritesRepositoryImpl {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
}

extension FavoritesRepositoryImpl: FavoritesRepository {

    func getFavorites() async throws -> [Int] {
        let endpoint = FavoritesEndpoint.getFavorites
        let response: FavoritesResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)

        return response.data.map { $0.bookId }
    }

    func getFavoritesByBookId(bookId: Int) async throws -> [String] {
        let endpoint = FavoritesEndpoint.getFavoritesByBookId(bookId: bookId)
        let response: FavoritesResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)
        return response.data.map { $0.documentId }
    }

    func addToFavorites(bookId: Int) async throws {
        let endpoint = FavoritesEndpoint.addToFavorites
        let request = AddToFavoritesRequestDTO(data: .init(bookId: bookId))

        try await httpClient.sendRequestWithoutResponse(endpoint: endpoint, requestBody: request)
    }

    func removeFromFavorites(documentId: String) async throws {
        let endpoint = FavoritesEndpoint.removeFromFavorites(documentId: documentId)

        try await httpClient.sendRequestWithoutResponse(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)
    }
}
