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
    let bookTitle: String
    let author: String
    let bookId: Int

    init(
        id: Int = 0,
        text: String = "",
         bookTitle: String = "",
         author: String = "Неизвестный автор",
         bookId: Int = 0
    ) {
        self.id = id
        self.text = text
        self.bookTitle = bookTitle
        self.author = author
        self.bookId = bookId
    }
}
