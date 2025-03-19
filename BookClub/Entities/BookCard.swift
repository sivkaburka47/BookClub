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
    
    init(image: String = "", title: String = "", authors: [String] = [], genres: [String] = []) {
        self.image = image
        self.title = title
        self.authors = authors
        self.genres = genres
    }
}
