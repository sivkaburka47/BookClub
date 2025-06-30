//
//  QuotesResponseDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

import Foundation

struct QuotesResponseDTO: Codable {
    let data: [QuoteDTO]
    let meta: MetaDTO
}

struct QuoteDTO: Codable, Identifiable {
    let id: Int
    let documentId: String
    let text: String
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    let bookId: Int
}

extension QuoteDTO {
    func toDomain() -> Quote {
        Quote(
            id: id,
            text: text,
            bookId: bookId
        )
    }
}
