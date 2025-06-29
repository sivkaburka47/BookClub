//
//  GetBookByIdUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol GetBookByIdUseCase {
    func execute(bookId: Int) async throws -> BookDetails
}

final class GetBookByIdUseCaseImpl: GetBookByIdUseCase {
    private let repository: BookRepository
    private let progressRepository: ProgressRepository
    private let favoriteRepository: FavoritesRepository

    init(repository: BookRepository,
         progressRepository: ProgressRepository,
         favoriteRepository: FavoritesRepository
    ) {
        self.repository = repository
        self.progressRepository = progressRepository
        self.favoriteRepository = favoriteRepository
    }

    static func create() -> GetBookByIdUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = BookRepositoryImpl(httpClient: httpClient)
        let progressRepository = ProgressRepositoryImpl(httpClient: httpClient)
        let favoriteRepository = FavoritesRepositoryImpl(httpClient: httpClient)
        return GetBookByIdUseCaseImpl(repository: repository, progressRepository: progressRepository, favoriteRepository: favoriteRepository)
    }

    func execute(bookId: Int) async throws -> BookDetails {
        do {
            let book = try await repository.getBookById(bookId: bookId)
            let chapters = try await getBookChapters(bookId: bookId)
            let isFavorite = try await !favoriteRepository.getFavoritesByBookId(bookId: bookId).isEmpty
            print("isFavorite: \(isFavorite)")
            let activeChapterInfo: (chapterId: Int, value: Int)? = try await getActiveChapterInfoForBook(allChapters: chapters)

            return BookDetails(
                id: book.id,
                documentId: book.documentId,
                image: book.coverImageUrl ?? "",
                title: book.title,
                authors: book.authors.map(\.name),
                description: [book.description ?? ""],
                activeChapter: activeChapterInfo,
                chapters: chapters,
                isFavorite: isFavorite
            )
        } catch {
            throw error
        }
    }

    private func getBookChapters(bookId: Int) async throws -> [Chapter] {
        do {
            return try await repository.getBookChapters(bookId: bookId)
        } catch {
            throw error
        }
    }

    private func getActiveChapterInfoForBook(
        allChapters: [Chapter]
    ) async throws -> (chapterId: Int, value: Int)? {
        do {
            let progresses = try await progressRepository.getProgress()

            guard let maxValue = progresses.map(\.value).max() else {
                return nil
            }

            let topProgresses = progresses.filter { $0.value == maxValue }

            let bestProgress = topProgresses.max { lhs, rhs in
                let lhsOrder = allChapters.first(where: { $0.id == lhs.chapterId })?.order ?? 0
                let rhsOrder = allChapters.first(where: { $0.id == rhs.chapterId })?.order ?? 0
                return lhsOrder < rhsOrder
            }

            if let progress = bestProgress {
                return (chapterId: progress.chapterId, value: progress.value)
            } else {
                return nil
            }
        } catch {
            throw error
        }
    }


}
