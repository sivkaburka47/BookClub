//
//  Quote.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import Foundation

struct Quote: Identifiable {
    let id = UUID()
    let text: String
    let bookTitle: String
    let author: String
    
    init( text: String = "", bookTitle: String = "", author: String = "") {
        self.text = text
        self.bookTitle = bookTitle
        self.author = author
    }
}
