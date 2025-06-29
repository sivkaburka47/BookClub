//
//  FavoritesRepository.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

import Foundation

protocol FavoritesRepository {
    func getFavorites() async throws -> [Int]
    func addToFavorites(bookId: Int) async throws
    func removeFromFavorites(documentId: String) async throws
    func getFavoritesByBookId(bookId: Int) async throws -> [String] 
}
