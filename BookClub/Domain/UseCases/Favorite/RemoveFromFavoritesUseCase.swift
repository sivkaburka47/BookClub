//
//  RemoveFromFavoritesUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol RemoveFromFavoritesUseCase {
    func execute(bookId: Int) async throws
}

final class RemoveFromFavoritesUseCaseImpl: RemoveFromFavoritesUseCase {
    private let repository: FavoritesRepository

    init(repository: FavoritesRepository) {
        self.repository = repository
    }

    static func create() -> RemoveFromFavoritesUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = FavoritesRepositoryImpl(httpClient: httpClient)
        return RemoveFromFavoritesUseCaseImpl(repository: repository)
    }

    func execute(bookId: Int) async throws {
        do {
            let favorites = try await repository.getFavoritesByBookId(bookId: bookId)
            try await withThrowingTaskGroup(of: Void.self) { group in
                for documentId in favorites {
                    group.addTask {
                        try await self.repository.removeFromFavorites(documentId: documentId)
                    }
                }
                try await group.waitForAll()
            }
        } catch {
            throw error
        }
    }
}
