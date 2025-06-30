//
//  FavoritesResponseDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation

struct FavoritesResponseDTO: Codable {
    let data: [FavoriteDTO]
    let meta: MetaDTO
}

struct FavoriteDTO: Codable, Identifiable {
    let id: Int
    let documentId: String
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    let bookId: Int
}
