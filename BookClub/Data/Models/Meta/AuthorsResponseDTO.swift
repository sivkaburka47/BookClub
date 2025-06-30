//
//  AuthorsResponseDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation

struct AuthorsResponseDTO: Codable {
    let data: [AuthorDTO]
    let meta: MetaDTO
}

struct AuthorDTO: Codable, Identifiable {
    let id: Int
    let documentId: String
    let name: String
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    let avatarURL: String
}

extension AuthorDTO {
    func toDomain() -> Author {
        Author(
            id: id,
            image: avatarURL,
            name: name
        )
    }
}
