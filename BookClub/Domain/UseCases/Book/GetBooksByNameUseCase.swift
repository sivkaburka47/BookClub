//
//  GetBookByNameUseCase.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

protocol GetBookByNameUseCase {
    func execute(name: String) async throws -> [Book]
}

final class GetBookByNameUseCaseImpl: GetBookByNameUseCase {
    private let repository: BookRepository

    init(repository: BookRepository) {
        self.repository = repository
    }

    static func create() -> GetBookByNameUseCaseImpl {
        let httpClient = AlamofireHTTPClient()
        let repository = BookRepositoryImpl(httpClient: httpClient)
        return GetBookByNameUseCaseImpl(repository: repository)
    }

    func execute(name: String) async throws -> [Book] {
        do {
            return try await repository.findBooksByName(name: name)
        } catch {
            throw error
        }
    }
}
