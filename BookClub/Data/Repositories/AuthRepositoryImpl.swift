//
//  AuthRepositoryImpl.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

import KeychainAccess

final class AuthRepositoryImpl {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

}

extension AuthRepositoryImpl: AuthRepository {

    func register(credentials: Credentials) async throws {
        let request = RegisterRequestDTO(username: credentials.email, email: credentials.email, password: credentials.password)
        let endpoint = AuthEndpoint.register
        
        let response: AuthResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: request)

        let keychain = Keychain()
        try keychain.set(response.jwt, key: "authToken")
    }

    func login(credentials: Credentials) async throws {
        let request = LoginRequestDTO(identifier: credentials.email, password: credentials.password)
        let endpoint = AuthEndpoint.login

        let response: AuthResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: request)

        let keychain = Keychain()
        try keychain.set(response.jwt, key: "authToken")
    }
}
