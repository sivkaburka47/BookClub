//
//  Chapter.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 25.03.2025.
//

import Foundation

struct Chapter: Identifiable {
    let id: Int
    let documentId: String
    let title: String
    let text: String
    let order: Int

    init(id: Int = 0,
         documentId: String = "",
         title: String = "",
         text: String = "",
         order: Int = 0
    ) {
        self.id = id
        self.documentId = documentId
        self.title = title
        self.text = text
        self.order = order
    }
}
