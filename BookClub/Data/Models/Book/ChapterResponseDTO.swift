//
//  ChapterResponseDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation

struct ChapterResponseDTO: Codable {
    let data: [ChapterDTO]
    let meta: MetaDTO
}

struct ChapterDTO: Codable, Identifiable {
    let id: Int
    let documentId: String
    let text: String
    let title: String
    let order: Int
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
}

extension ChapterDTO {
    func toDomain() -> Chapter {
        Chapter(
            id: id,
            documentId: documentId,
            title: title,
            text: text,
            order: order
        )
    }
}

struct ChapterWithBookResponseDTO: Codable {
    let data: [ChapterWithBookDTO]
    let meta: MetaDTO
}

struct ChapterWithBookDTO: Codable {
    let id: Int
    let documentId: String
    let text: String
    let title: String
    let order: Int
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    let book: BookWithoutAuthorsDTO

    func toReadingStatus() -> ReadingStatus {
        ReadingStatus(
            id: id,
            bookId: book.id,
            bookTitle: book.title,
            bookImageUrl: book.coverURL,
            chapterTitle: title,
            value: 0
        )
    }
}
