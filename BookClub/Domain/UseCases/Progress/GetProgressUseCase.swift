//
//  GetProgressUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

import Foundation

protocol GetProgressUseCase {
    func execute() async throws -> ReadingStatus?
}

final class GetProgressUseCaseImpl: GetProgressUseCase {
    private let repository: ProgressRepository
    private let bookRepository: BookRepository

    init(
        repository: ProgressRepository,
        bookRepository: BookRepository
    ) {
        self.repository = repository
        self.bookRepository = bookRepository
    }

    static func create() -> GetProgressUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = ProgressRepositoryImpl(httpClient: httpClient)
        let bookRepository = BookRepositoryImpl(httpClient: httpClient)
        return GetProgressUseCaseImpl(repository: repository, bookRepository: bookRepository)
    }

    func execute() async throws -> ReadingStatus? {

        do {
            let progresses = try await repository.getProgress()

            guard let progress = getLastReadChapter(from: progresses) else {
                return nil
            }

            guard var readingStatus = try await bookRepository.getChapterWithBook(chapterId: progress.chapterId) else {
                return nil
            }
            readingStatus.value = Double(progress.value)

            return readingStatus
        } catch {
            throw error
        }
    }

    func getLastReadChapter(from progresses: [Progress]) -> Progress? {

        let filteredProgresses = progresses.filter { $0.value > 0 }

        let sortedProgresses = filteredProgresses.sorted { (progress1, progress2) in
            if progress1.value == progress2.value {
                return progress1.updatedAt > progress2.updatedAt
            } else {
                return progress1.value > progress2.value
            }
        }

        return sortedProgresses.first
    }
}
