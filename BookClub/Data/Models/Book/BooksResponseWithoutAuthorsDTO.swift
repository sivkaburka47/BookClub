//
//  BooksResponseWithoutAuthorsDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 27.06.2025.
//

import Foundation

struct BooksResponseWithoutAuthorsDTO: Codable {
    let data: [BookWithoutAuthorsDTO]
    let meta: MetaDTO
}

struct BookWithoutAuthorsDTO: Codable {
    let id: Int
    let documentId: String
    let title: String
    let coverURL: String
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    let isNew: Bool
    let illustrationURL: String?
    let description: String
}

extension BookWithoutAuthorsDTO {
    func toDomain() -> Book {
        Book(
            id: id,
            documentId: documentId,
            title: title,
            coverImageUrl: coverURL,
            createdAt: ISO8601DateFormatter().date(from: createdAt) ?? Date(),
            updatedAt: ISO8601DateFormatter().date(from: updatedAt) ?? Date(),
            publishedAt: ISO8601DateFormatter().date(from: publishedAt) ?? Date(),
            isNew: isNew,
            authors: [],
            genres: ["Жанры неизвестны"],
            description: description
        )
    }
}
