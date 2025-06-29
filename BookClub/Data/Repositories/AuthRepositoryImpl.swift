//
//  AuthRepositoryImpl.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

import KeychainAccess
import Foundation

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

        do {
            let response: AuthResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: request)
            let keychain = Keychain()
            try keychain.set(response.jwt, key: "authToken")
        } catch let error as NSError where error.domain == "HTTPClientError" {
            let decoder = JSONDecoder()
            if let errorData = error.userInfo["data"] as? Data,
               let errorResponse = try? decoder.decode(ErrorResponseDTO.self, from: errorData),
               let errorDetails = errorResponse.error {
                throw AuthError.serverError(status: errorDetails.status, message: errorDetails.message)
            }
            throw AuthError.networkError(error)
        } catch {
            throw AuthError.unknown(error)
        }
    }

    func login(credentials: Credentials) async throws {
        let request = LoginRequestDTO(identifier: credentials.email, password: credentials.password)
        let endpoint = AuthEndpoint.login

        do {
            let response: AuthResponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: request)
            let keychain = Keychain()
            try keychain.set(response.jwt, key: "authToken")
        } catch let error as NSError where error.domain == "HTTPClientError" {
            let decoder = JSONDecoder()
            if let errorData = error.userInfo["data"] as? Data,
               let errorResponse = try? decoder.decode(ErrorResponseDTO.self, from: errorData),
               let errorDetails = errorResponse.error {
                if errorDetails.name == "ValidationError" {
                    throw AuthError.invalidCredentials(errorDetails.message)
                }
                throw AuthError.serverError(status: errorDetails.status, message: errorDetails.message)
            }
            throw AuthError.networkError(error)
        } catch {
            throw AuthError.unknown(error)
        }
    }
}
