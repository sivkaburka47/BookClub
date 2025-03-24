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

// MARK: - Properties
private extension SearchView {
    var filteredBooks: [BookCard] {
        books.filter { book in
            let searchLowercased = searchText.lowercased()
            return book.title.lowercased().contains(searchLowercased) ||
                   book.authors.contains { $0.lowercased().contains(searchLowercased) } ||
                   book.genres.contains { $0.lowercased().contains(searchLowercased) }
        }
    }
}

// MARK: View Components
private extension SearchView {
    @ViewBuilder
    var genresSection: some View {
        Group {
            if !genres.isEmpty {
                GenresGridView(genres: genres) { selectedGenre in
                    searchText = selectedGenre
                }
            }
        }
    }
    
    @ViewBuilder
    var recentRequestsSection: some View {
        Group {
            if !recentRequests.isEmpty {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Недавние запросы")
                        .h2TextStyle()
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(recentRequests, id: \.self) { request in
                            recentRequestRow(for: request)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func recentRequestRow(for request: String) -> some View {
        HStack {
            CustomIcon(name: "History", size: 24, color: Color("AccentDark"))
            Text(request)
                .bodySmallTextStyle()
                .frame(maxWidth: .infinity, alignment: .leading)
            CustomIcon(name: "Close", size: 24, color: Color("AccentDark"))
                .padding(8)
                .onTapGesture {
                    recentRequests.removeAll { $0 == request }
                }
        }
        .padding(.leading, 16)
        .padding(.trailing, 4)
        .padding(.vertical, 4)
        .background(Color("AccentLight"))
        .cornerRadius(8)
        .onTapGesture {
            searchText = request
        }
    }
    
    @ViewBuilder
    var authorsSection: some View {
        Group {
            if !authors.isEmpty {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Авторы")
                        .h2TextStyle()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(authors, id: \.name) { author in
                            authorRowView(for: author)
                                .onTapGesture {
                                    searchText = author.name
                                }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func authorRowView(for author: Author) -> some View {
        HStack(alignment: .center, spacing: 12) {
            Image(author.image)
                .resizable()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            Text(author.name)
                .bodyTextStyle()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color("AccentLight"))
        .cornerRadius(8)
    }
    
    @ViewBuilder
    var booksSection: some View {
        BookListView(books: filteredBooks, spacing: 16)
    }
}

#Preview {
    SearchView()
}
