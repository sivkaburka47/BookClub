//
//  RegisterUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol RegisterUseCase {
    func execute(request: Credentials) async throws
}

final class RegisterUseCaseImpl: RegisterUseCase {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    static func create() -> RegisterUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = AuthRepositoryImpl(httpClient: httpClient)
        return RegisterUseCaseImpl(repository: repository)
    }

    func execute(request: Credentials) async throws {
        do {
            try await repository.register(credentials: request)
        } catch {
            throw error
        }
    }
}
