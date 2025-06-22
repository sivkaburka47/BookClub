//
//  MetaRepositoryImpl.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

import Foundation

protocol MetaRepositoryImpl {
    func getAuthors() async throws -> AuthorsResponseDTO
    func getGenres(bookId: Int) async throws -> GenresResponseDTO
}
