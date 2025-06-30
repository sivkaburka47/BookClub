//
//  GodService.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation
import KeychainAccess

final class GodService {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient = AlamofireHTTPClient()) {
        self.httpClient = httpClient
    }

    func login(email: String, password: String) async throws {
        let request = LoginRequestDTO(identifier: email, password: password)
        let response: AuthResponseDTO = try await httpClient.sendRequest(endpoint: AuthEndpoint.login, requestBody: request)

        let keychain = Keychain()
        try keychain.set(response.jwt, key: "authToken")
    }

    func fetchBooks() async throws -> [BookDTO] {
        let endpoint = BookEndpoint.getBooks()
        let response: BooksResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)
        return response.data
    }
}
