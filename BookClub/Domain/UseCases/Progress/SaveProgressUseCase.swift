//
//  SaveProgressUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol SaveProgressUseCase {
    func execute(progress: Progress) async throws
}

final class SaveProgressUseCaseImpl: SaveProgressUseCase {
    private let repository: ProgressRepository

    init(repository: ProgressRepository) {
        self.repository = repository
    }

    static func create() -> SaveProgressUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = ProgressRepositoryImpl(httpClient: httpClient)
        return SaveProgressUseCaseImpl(repository: repository)
    }

    func execute(progress: Progress) async throws {
        do {
            try await repository.saveProgress(progress: progress)
        } catch {
            throw error
        }
    }
}
