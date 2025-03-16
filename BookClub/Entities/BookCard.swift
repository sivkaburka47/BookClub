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
    let author: String
    
    init(image: String = "", title: String = "", author: String = "") {
        self.image = image
        self.title = title
        self.author = author
    }
}
