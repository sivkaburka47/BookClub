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
    let coverImageUrl: String?
    let createdAt: Date
    let updatedAt: Date
    let publishedAt: Date
    let isNew: Bool
    let authors: [Author]
    let genres: [String]
    let description: String?

    init(id: Int = 0,
         documentId: String = "",
         title: String = "",
         coverImageUrl: String? = nil,
         createdAt: Date = Date(),
         updatedAt: Date = Date(),
         publishedAt: Date = Date(),
         isNew: Bool = false,
         authors: [Author] = [],
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

extension Book {
    func toFeaturedBookCard() -> FeaturedBookCard {
        FeaturedBookCard(
            id: id,
            image: coverImageUrl ?? "https://litclubbs.ru/news/3899-novaja-zaglushka-dlja-oblozhek.html",
            title: title,
            description: description ?? "Описание отсутствует"
        )
    }

    func toBookGridCard() -> BookGridCard {
        BookGridCard(
            id: id,
            image: coverImageUrl ?? "https://litclubbs.ru/news/3899-novaja-zaglushka-dlja-oblozhek.html",
            title: title,
            authors: authors
        )
    }
}
