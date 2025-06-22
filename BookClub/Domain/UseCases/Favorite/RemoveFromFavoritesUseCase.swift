//
//  RemoveFromFavoritesUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol RemoveFromFavoritesUseCase {
    func execute(documentId: String) async throws
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

    func execute(documentId: String) async throws {
        do {
            return try await repository.removeFromFavorites(documentId: documentId)
        } catch {
            throw error
        }
    }
}
