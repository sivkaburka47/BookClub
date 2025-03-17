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
    let activeChapter: Int
    let chapters: [String]
    
    var currentChapter: String {
        guard activeChapter >= 0, activeChapter < chapters.count else { return "Неизвестная глава" }
        return chapters[activeChapter]
    }
    
    var progress: Double {
        return chapters.isEmpty ? 0 : Double(activeChapter + 1) / Double(chapters.count)
    }
}
