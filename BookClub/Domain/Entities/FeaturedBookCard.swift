//
//  FeaturedBookCard.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 27.06.2025.
//

import Foundation

struct FeaturedBookCard: Identifiable {
    let id: Int
    let image: String
    let title: String
    let description: String

    init(id: Int = 0, image: String = "", title: String = "", description: String = "") {
        self.id = id
        self.image = image
        self.title = title
        self.description = description
    }
}
