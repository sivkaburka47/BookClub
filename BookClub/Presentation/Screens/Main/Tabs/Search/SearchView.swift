//
//  SearchView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    
    let genres = [
        "Классика", "Фэнтези", "Фантастика", "Детектив",
        "Триллер", "Исторический роман", "Любовный роман", "Приключения",
        "Поэзия", "Биография", "Для подростков", "Для детей"
    ]
    
    @State private var recentRequests = ["Android", "iOS", "Windows", "Linux", "MacOS"]
    
    @State private var authors = [
        Author(image: "book", name: "Братья Стругацкие"),
        Author(image: "book", name: "Дэн Браун"),
        Author(image: "book", name: "Федор Достоевский"),
        Author(image: "book", name: "Альберт Эйнштейн"),
        Author(image: "book", name: "Лев Толстой")
    ]
    
    @State private var books = [
        BookCard(image: "book", title: "Программирование на SWIFT для IOS", authors: ["Братья Стругацкие"], genres: ["Фантастика", "Приключения"]),
        BookCard(image: "book", title: "Код да Винчи", authors: ["Дэн Браун"], genres: ["Детектив", "Триллер"]),
        BookCard(image: "book", title: "Преступление и наказание", authors: ["Федор Достоевский"], genres: ["Классика", "Детектив"]),
        BookCard(image: "book", title: "Мир как он есть", authors: ["Альберт Эйнштейн"], genres: ["Биография", "Научпоп"]),
        BookCard(image: "book", title: "Война и мир", authors: ["Лев Толстой"], genres: ["Классика", "Исторический роман"]),
        BookCard(image: "book", title: "Гарри Поттер и философский камень", authors: ["Джоан Роулинг"], genres: ["Фэнтези", "Приключения"]),
        BookCard(image: "book", title: "Шерлок Холмс", authors: ["Артур Конан Дойл"], genres: ["Детектив", "Классика"]),
        BookCard(image: "book", title: "1984", authors: ["Джордж Оруэлл"], genres: ["Фантастика", "Антиутопия"]),
        BookCard(image: "book", title: "Анна Каренина", authors: ["Лев Толстой"], genres: ["Классика", "Любовный роман"]),
        BookCard(image: "book", title: "Дюна", authors: ["Фрэнк Герберт"], genres: ["Фантастика", "Приключения"])
    ]

    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    CustomSearchBar(text: $searchText)
                    
                    if searchText.isEmpty {
                        recentRequestsSection
                        genresSection
                        authorsSection
                    } else {
                        booksSection
                    }
                    
                    Spacer().frame(height: 100)
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

extension SearchView {
    var filteredBooks: [BookCard] {
        books.filter { book in
            let searchLowercased = searchText.lowercased()
            return book.title.lowercased().contains(searchLowercased) ||
                   book.authors.contains { $0.lowercased().contains(searchLowercased) } ||
                   book.genres.contains { $0.lowercased().contains(searchLowercased) }
        }
    }
    
    var genresSection: some View {
        Group {
            if !genres.isEmpty {
                GenresGridView(genres: genres) { selectedGenre in
                    searchText = selectedGenre
                }
            }
        }
    }
    
    var recentRequestsSection: some View {
        Group {
            if !recentRequests.isEmpty {
                RecentRequestsView(recentRequests: $recentRequests) { selectedRequest in
                    searchText = selectedRequest
                }
            }
        }
    }
    
    var authorsSection: some View {
        Group {
            if !authors.isEmpty {
                AuthorsListView(authors: authors) { selectedAuthor in
                    searchText = selectedAuthor
                }
            }
        }
    }
    
    var booksSection: some View {
        BookListView(books: filteredBooks, spacing: 16)
    }
}

#Preview {
    SearchView()
}
