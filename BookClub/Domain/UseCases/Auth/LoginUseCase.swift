//
//  LoginUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol LoginUseCase {
    func execute(request: Credentials) async throws
}

final class LoginUseCaseImpl: LoginUseCase {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    static func create() -> LoginUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = AuthRepositoryImpl(httpClient: httpClient)
        return LoginUseCaseImpl(repository: repository)
    }

    func execute(request: Credentials) async throws {
        do {
            try await repository.login(credentials: request)
        } catch {
            throw error
        }
    }
}
