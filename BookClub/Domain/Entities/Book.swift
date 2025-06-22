//
//  Book.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

import Foundation

struct Book: Identifiable {
    let id: Int
    let documentId: String
    let title: String
    let coverImageUrl: URL?
    let createdAt: Date
    let updatedAt: Date
    let publishedAt: Date
    let isNew: Bool
    let authors: [String]
    let genres: [String]
    let description: String?

    init(id: Int = 0,
         documentId: String = "",
         title: String = "",
         coverImageUrl: URL?,
         createdAt: Date = Date(),
         updatedAt: Date = Date(),
         publishedAt: Date = Date(),
         isNew: Bool = false,
         authors: [String] = [],
         genres: [String] = [],
         description: String? = nil
    ) {
        self.id = id
        self.documentId = documentId
        self.title = title
        self.coverImageUrl = coverImageUrl
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.publishedAt = publishedAt
        self.isNew = isNew
        self.authors = authors
        self.genres = genres
        self.description = description
    }
}
