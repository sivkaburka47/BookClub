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
    
    @State private var books = [
        BookCard(image: "book", title: "Пикник на обочине", author: "Братья Стругацкие"),
        BookCard(image: "book", title: "Код да Винчи", author: "Дэн Браун"),
        BookCard(image: "book", title: "Преступление и наказание", author: "Федор Достоевский"),
        BookCard(image: "book", title: "Мир как он есть", author: "Альберт Эйнштейн"),
        BookCard(image: "book", title: "Война и мир", author: "Лев Толстой")
    ]
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ScreenTitle(text: "Закладки")
                    CurrentReadingSection(book: book)
                    VStack(alignment: .leading, spacing: 8) {
                        SectionTitle(text: "Избранные книги")
                        BookListView(books: books)
                    }
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
