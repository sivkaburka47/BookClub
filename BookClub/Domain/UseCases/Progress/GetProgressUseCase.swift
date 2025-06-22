//
//  GetProgressUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol GetProgressUseCase {
    func execute() async throws -> [Progress]
}

final class GetProgressUseCaseImpl: GetProgressUseCase {
    private let repository: ProgressRepository

    init(repository: ProgressRepository) {
        self.repository = repository
    }

    static func create() -> GetProgressUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = ProgressRepositoryImpl(httpClient: httpClient)
        return GetProgressUseCaseImpl(repository: repository)
    }

    func execute() async throws -> [Progress] {
        do {
            return try await repository.getProgress()
        } catch {
            throw error
        }
    }
}
