//
//  UpdateProgressUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol UpdateProgressUseCase {
    func execute(progress: Progress) async throws
}

final class UpdateProgressUseCaseImpl: UpdateProgressUseCase {
    private let repository: ProgressRepository

    init(repository: ProgressRepository) {
        self.repository = repository
    }

    static func create() -> UpdateProgressUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = ProgressRepositoryImpl(httpClient: httpClient)
        return UpdateProgressUseCaseImpl(repository: repository)
    }

    func execute(progress: Progress) async throws {
        do {
            try await repository.updateProgress(documentId: progress.documentId, progress: progress)
        } catch {
            throw error
        }
    }
}
