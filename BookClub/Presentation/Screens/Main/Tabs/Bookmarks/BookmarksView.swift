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
        activeChapter: 0,
        chapters: ["Пролог", "Глава 1", "Глава 2", "Глава 3"]
    )
    
    @State private var books = [
        BookCard(image: "book", title: "Пикник на обочине", authors: ["Братья Стругацкие", "Альберт Эйнштейн"]),
        BookCard(image: "book", title: "Код да Винчи", authors: ["Дэн Браун"]),
        BookCard(image: "book", title: "Преступление и наказание", authors: ["Федор Достоевский", "Альберт Эйнштейн", "Дэн Браун"]),
        BookCard(image: "book", title: "Мир как он есть", authors: ["Альберт Эйнштейн"]),
        BookCard(image: "book", title: "Война и мир", authors: ["Лев Толстой"])
    ]
    
    @State private var quotes = [
        Quote(text: "Я все еще жив", bookTitle: "Код Да Винчи", author: "Дэн Браун"),
        Quote(text: "Высокий, широкоплечий, с мертвенно-бледной кожей и редкими белыми волосами", bookTitle: "Код Да Винчи", author: "Дэн Браун")
    ]
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Закладки")
                        .h1TextStyle()
                        .foregroundColor(Color("Secondary"))
                    
                    currentReadingSection
                    favoritesSection
                    quotesSection
                    Spacer().frame(height: 100)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            }
        }
    }
}

extension BookmarksView {
    var currentReadingSection: some View {
        Group {
            CurrentReadingSection(book: book)
        }
    }
    
    var favoritesSection: some View {
        Group {
            if !books.isEmpty {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Избранные книги")
                        .h2TextStyle()
                    BookListView(books: books, spacing: 8)
                    
                }
            }
        }
    }
    
    var quotesSection: some View {
        Group {
            if !quotes.isEmpty {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Цитаты")
                        .h2TextStyle()
                    QuotesListView(quotes: quotes)
                    
                }
            }
        }
    }
}

#Preview {
    BookmarksView()
}
