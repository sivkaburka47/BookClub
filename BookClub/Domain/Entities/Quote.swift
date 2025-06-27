//
//  Quote.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import Foundation

struct Quote: Identifiable {
    let id: Int
    let text: String
    var bookTitle: String
    var authors: [Author]
    let bookId: Int

    init(
        id: Int = 0,
        text: String = "",
        bookTitle: String = "",
        authors: [Author] = [],
        bookId: Int = 0
    ) {
        self.id = id
        self.text = text
        self.bookTitle = bookTitle
        self.authors = authors
        self.bookId = bookId
    }
}
