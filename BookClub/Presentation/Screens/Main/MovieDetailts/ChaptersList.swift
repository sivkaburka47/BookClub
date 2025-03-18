//
//  ChaptersList.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 18.03.2025.
//

import SwiftUI

struct ChaptersList: View {
    let chapters: [String]
    let activeChapter: Int?
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(chapters.indices, id: \.self) { index in
                let isActive = activeChapter == index
                let isRead = activeChapter != nil && index < activeChapter!
                
                ChapterRow(chapter: chapters[index], isActive: isActive, isRead: isRead)
            }
        }
    }
}
