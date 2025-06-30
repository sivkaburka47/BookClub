//
//  GetAuthorsUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol GetAuthorsUseCase {
    func execute() async throws -> [Author]
}

final class GetAuthorsUseCaseImpl: GetAuthorsUseCase {
    private let repository: MetaRepository

    init(repository: MetaRepository) {
        self.repository = repository
    }

    static func create() -> GetAuthorsUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = MetaRepositoryImpl(httpClient: httpClient)
        return GetAuthorsUseCaseImpl(repository: repository)
    }

    func execute() async throws -> [Author] {
        do {
            return try await repository.getAuthors()
        } catch {
            throw error
        }
    }
}
