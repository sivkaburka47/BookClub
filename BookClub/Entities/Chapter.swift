//
//  Chapter.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 25.03.2025.
//

import Foundation

struct Chapter: Identifiable {
    let id = UUID()
    let title: String
    let text: String
}
