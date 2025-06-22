//
//  AddToFavoritesUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol AddToFavoritesUseCase {
    func execute(bookId: Int) async throws
}

final class AddToFavoritesUseCaseImpl: AddToFavoritesUseCase {
    private let repository: FavoritesRepository

    init(repository: FavoritesRepository) {
        self.repository = repository
    }

    static func create() -> AddToFavoritesUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = FavoritesRepositoryImpl(httpClient: httpClient)
        return AddToFavoritesUseCaseImpl(repository: repository)
    }

    func execute(bookId: Int) async throws {
        do {
            return try await repository.addToFavorites(bookId: bookId)
        } catch {
            throw error
        }
    }
}
