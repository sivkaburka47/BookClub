//
//  GetGenresUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol GetGenresUseCase {
    func execute() async throws -> [Genre]
}

final class GetGenresUseCaseImpl: GetGenresUseCase {
    private let repository: MetaRepository

    init(repository: MetaRepository) {
        self.repository = repository
    }

    static func create() -> GetGenresUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = MetaRepositoryImpl(httpClient: httpClient)
        return GetGenresUseCaseImpl(repository: repository)
    }

    func execute() async throws -> [Genre] {
        do {
            return try await repository.getGenres()
        } catch {
            throw error
        }
    }
}
