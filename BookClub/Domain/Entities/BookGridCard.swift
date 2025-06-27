//
//  BookGridCard.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 27.06.2025.
//

import Foundation

struct BookGridCard: Identifiable {
    let id: Int
    let image: String
    let title: String
    let authors: [Author]

    init(id: Int = 0, image: String = "", title: String = "", authors: [Author] = []) {
        self.id = id
        self.image = image
        self.title = title
        self.authors = authors
    }
}
