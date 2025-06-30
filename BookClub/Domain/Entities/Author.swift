//
//  Author.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import Foundation

struct Author: Identifiable {
    let id: Int
    let image: String
    let name: String

    init(id: Int = 0, image: String = "book", name: String = "Неизвестный автор") {
        self.id = id
        self.image = image
        self.name = name
    }
}
