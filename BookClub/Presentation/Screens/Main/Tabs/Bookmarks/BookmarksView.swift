//
//  BookmarksView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct BookmarksView: View {
    let book = BookDetails(
        image: "book",
        title: "Код Да Винчи",
        author: "bebrik",
        activeChapter: 1,
        chapters: ["Пролог", "Глава 1", "Глава 2", "Глава 3"]
    )
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    ScreenTitle(text: "Закладки")
                    CurrentReadingSection(book: book)
                    Spacer().frame(height: 100)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    BookmarksView()
}
