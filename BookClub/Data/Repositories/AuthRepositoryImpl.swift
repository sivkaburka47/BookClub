//
//  AuthRepositoryImpl.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

final class AuthRepositoryImpl: AuthRepository {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

}

extension AuthRepositoryImpl: AuthRepository {

//    func register(request: RegisterRequestDTO) async throws {
//        let endpoint = AuthEndpoint.register
//        try await httpClient.sendRequestWithoutResponse(endpoint: endpoint, requestBody: request)
//    }
//
//    func login(request: LoginRequestDTO) async throws {
//        let endpoint = AuthEndpoint.login
//        try await httpClient.sendRequestWithoutResponse(endpoint: endpoint, requestBody: request)
//    }
}
