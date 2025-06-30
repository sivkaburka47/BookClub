//
//  MetaRepositoryImpl.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

final class MetaRepositoryImpl {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
}

extension MetaRepositoryImpl: MetaRepository {

    func getAuthors() async throws -> [Author] {
        let endpoint = MetaEndpoint.getAuthors
        let response: AuthorsResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)

        return response.data.map { $0.toDomain() }
    }

    func getGenres() async throws -> [Genre] {
        let endpoint = MetaEndpoint.getGenres
        let response: GenresResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)

        return response.data.map { $0.toDomain() }
    }
}
