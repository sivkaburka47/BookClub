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
        Author(image: "book", name: "Эйнштейн"),
        Author(image: "book", name: "Лев Толстой")
    ]
    
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
        books.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    
    var genresSection: some View {
        Group {
            if !genres.isEmpty {
                GenresGridView(genres: genres)
            }
        }
    }
    
    var recentRequestsSection: some View {
        Group {
            if !recentRequests.isEmpty {
                RecentRequestsView(recentRequests: $recentRequests)
            }
        }
    }
    
    var authorsSection: some View {
        Group {
            if !authors.isEmpty {
                AuthorsListView(authors: authors)
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
