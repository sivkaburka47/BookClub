//
//  BookDetails.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import Foundation

struct BookDetails: Identifiable {
    let id: Int
    let documentId: String
    let image: String
    let title: String
    let authors: [String]
    let description: [String]
    let activeChapter: (chapterId: Int, value: Int)?
    let chapters: [Chapter]
    var isFavorite: Bool

    var currentChapter: Chapter {
        guard
            let chapterId = activeChapter?.chapterId,
            let chapter = chapters.first(where: { $0.id == chapterId })
        else {
            return Chapter(id: 0, documentId: "str", title: "Неизвестная глава", text: "Текст отсутствует")
        }
        return chapter
    }

    var progress: Double {
        guard
            let chapterId = activeChapter?.chapterId,
            let currentIndex = chapters.firstIndex(where: { $0.id == chapterId }),
            !chapters.isEmpty
        else {
            return 0
        }
        return Double(currentIndex + 1) / Double(chapters.count)
    }

    init(
        id: Int = 0,
        documentId: String = "",
        image: String = "",
        title: String = "",
        authors: [String] = [],
        description: [String] = [],
        activeChapter: (chapterId: Int, value: Int)? = nil,
        chapters: [Chapter] = [],
        isFavorite: Bool = false
    ) {
        self.id = id
        self.documentId = documentId
        self.image = image
        self.title = title
        self.authors = authors
        self.description = description
        self.activeChapter = activeChapter
        self.chapters = chapters
        self.isFavorite = isFavorite
    }
}
