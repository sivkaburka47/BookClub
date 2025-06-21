//
//  BookParagraph.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 24.03.2025.
//

import Foundation

struct BookParagraph: Identifiable {
    let id = UUID()
    let lines: [BookLine]
}
