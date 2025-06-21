//
//  BookCard.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import Foundation

struct BookCard: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let authors: [String]
    let genres: [String]
    let description: String?
    
    init(image: String = "", title: String = "", authors: [String] = [], genres: [String] = [], description: String? = nil) {
        self.image = image
        self.title = title
        self.authors = authors
        self.genres = genres
        self.description = description
    }
}
