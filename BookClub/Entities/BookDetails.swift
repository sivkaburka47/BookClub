//
//  BookDetails.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import Foundation

struct BookDetails: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let author: String
    let description: [String]
    let activeChapter: Int?
    let chapters: [String]
    
    var currentChapter: String {
        guard let activeChapter = activeChapter, activeChapter >= 0, activeChapter < chapters.count else {
            return "Неизвестная глава"
        }
        return chapters[activeChapter]
    }
    
    var progress: Double {
        guard let activeChapter = activeChapter, !chapters.isEmpty else { return 0 }
        return Double(activeChapter + 1) / Double(chapters.count)
    }
    
    init(
        image: String,
        title: String,
        author: String,
        description: [String] = [],
        activeChapter: Int? = nil,
        chapters: [String] = []
    ) {
        self.image = image
        self.title = title
        self.author = author
        self.description = description
        self.activeChapter = activeChapter
        self.chapters = chapters
    }
}
