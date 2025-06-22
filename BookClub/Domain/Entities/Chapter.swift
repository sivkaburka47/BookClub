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

    init(id: Int = 0,
         documentId: String = "",
         title: String = "",
         text: String = ""
    ) {
        self.id = id
        self.documentId = documentId
        self.title = title
        self.text = text
    }
}
