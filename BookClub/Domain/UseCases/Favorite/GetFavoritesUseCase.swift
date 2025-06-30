//
//  GetFavoritesUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol GetFavoritesUseCase {
    func execute() async throws -> [BookGridCard]
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

    func execute() async throws -> [BookGridCard] {
        let favoriteIdsArray = try await getFavoriteIds()
        let favoriteIds = Set(favoriteIdsArray)

        if favoriteIds.isEmpty {
            return []
        }

        return try await withThrowingTaskGroup(of: Book?.self) { group in
            for bookId in favoriteIds {
                group.addTask {
                    do {
                        let book = try await self.bookRepository.getBookById(bookId: bookId)
                        return book
                    } catch {
                        return nil
                    }
                }
            }

            var books: [Book] = []
            for try await book in group {
                if let book = book {
                    books.append(book)
                }
            }

            let bookGridCards = books.map { $0.toBookGridCard() }
            return bookGridCards
        }
    }

    private func getFavoriteIds() async throws -> [Int] {
        let ids = try await favoriteRepository.getFavorites()
        return ids
    }
}
