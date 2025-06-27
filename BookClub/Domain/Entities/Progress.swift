//
//  Progress.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

import Foundation

struct Progress: Identifiable {
    let id: Int
    let updatedAt: Date
    let documentId: String
    let value: Int
    let chapterId: Int
}

struct ActiveBook {
    let bookId: Int
    let bookTitle: String
    let bookImageUrl: String
    let chapterTitle: String
    let progressValue: Int
}
