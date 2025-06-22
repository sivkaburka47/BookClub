//
//  GenresResponseDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation

struct GenresResponseDTO: Codable {
    let data: [GenreDTO]
    let meta: MetaDTO
}

struct GenreDTO: Codable, Identifiable {
    let id: Int
    let documentId: String
    let name: String
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
}

extension GenreDTO {
    func toDomain() -> Genre {
        Genre(
            id: id,
            name: name
        )
    }
}
