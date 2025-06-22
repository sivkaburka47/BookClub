//
//  GetFavoritesUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol GetFavoritesUseCase {
    func execute() async throws -> [Book]
}

final class GetFavoritesUseCaseImpl: GetFavoritesUseCase {
    private let favoriteRepository: FavoritesRepository
    private let bookRepository: BookRepository

    init(
        favoriteRepository: FavoritesRepository,
        bookRepository: BookRepository
    ) {
        self.favoriteRepository = favoriteRepository
        self.bookRepository = bookRepository
    }

    static func create() -> GetFavoritesUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let favoriteRepository = FavoritesRepositoryImpl(httpClient: httpClient)
        let bookRepository = BookRepositoryImpl(httpClient: httpClient)
        return GetFavoritesUseCaseImpl(favoriteRepository: favoriteRepository, bookRepository: bookRepository)
    }

    func execute() async throws -> [Book] {
        let favoriteIds = try await getFavoriteIds()

        return try await withThrowingTaskGroup(of: Book?.self) { group in
            for bookId in favoriteIds {
                group.addTask {
                    try? await self.bookRepository.getBookById(bookId: bookId)
                }
            }

            var books: [Book] = []

            for try await book in group {
                if let book = book {
                    books.append(book)
                }
            }

            return books
        }
    }

    func getFavoriteIds() async throws -> [Int] {
        do {
            return try await favoriteRepository.getFavorites()
        } catch {
            throw error
        }
    }
}
