//
//  SearchView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct SearchView: View {

    let getGenresUseCase: GetGenresUseCase = GetGenresUseCaseImpl.create()
    let getAuthorsUseCase: GetAuthorsUseCase = GetAuthorsUseCaseImpl.create()
    let getBookByNameUseCase: GetBookByNameUseCase = GetBookByNameUseCaseImpl.create()
    let getBooksByAuthorUseCase: GetBooksByAuthorUseCase = GetBooksByAuthorUseCaseImpl.create()
    let getBooksByGenreUseCase: GetBooksByGenreUseCase = GetBooksByGenreUseCaseImpl.create()

    @State private var searchTask: Task<Void, Never>? = nil
    @State private var matchedGenreIds: [Int] = []
    @State private var matchedAuthorIds: [Int] = []

    @State private var searchText: String = ""
    @State private var genres: [Genre] = []
    @State private var recentRequests = ["Android", "iOS", "Windows", "Linux", "MacOS"]
    @State private var authors: [Author] = []

    @State private var books: [BookGridCard] = []

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
            .onChange(of: searchText) { newValue in
                searchTask?.cancel()

                guard !newValue.isEmpty else {
                    books = []
                    matchedGenreIds = []
                    matchedAuthorIds = []
                    return
                }

                searchTask = Task {
                    try? await Task.sleep(nanoseconds: 500_000_000)
                    guard !Task.isCancelled else { return }

                    let matchedGenres = genres.filter {
                        $0.name.lowercased().contains(newValue.lowercased())
                    }
                    matchedGenreIds = matchedGenres.map { $0.id }

                    let matchedAuthors = authors.filter {
                        $0.name.lowercased().contains(newValue.lowercased())
                    }
                    matchedAuthorIds = matchedAuthors.map { $0.id }

                    await searchBooks()
                }

            }
        }
        .task {
            await loadMeta()
        }
    }
    
}

private extension SearchView {
    @MainActor
    private func searchBooks() async {
        do {
            async let booksByName = getBookByNameUseCase.execute(name: searchText)
            async let booksByGenres = fetchBooksByGenres(ids: matchedGenreIds)
            async let booksByAuthors = fetchBooksByAuthors(ids: matchedAuthorIds)

            let (byName, byGenres, byAuthors) = try await (booksByName, booksByGenres, booksByAuthors)
            let combinedBooks = (byName + byGenres + byAuthors)
            let uniqueBooks = Array(Dictionary(grouping: combinedBooks, by: { $0.id }).values.compactMap { $0.first })

            books = uniqueBooks
        } catch {
            print("Ошибка при поиске книг: \(error.localizedDescription)")
        }
    }

    private func fetchBooksByGenres(ids: [Int]) async throws -> [BookGridCard] {
        var allBooks: [BookGridCard] = []
        for id in ids {
            let books = try await getBooksByGenreUseCase.execute(genre: id)
            allBooks.append(contentsOf: books)
        }
        return allBooks
    }

    private func fetchBooksByAuthors(ids: [Int]) async throws -> [BookGridCard] {
        var allBooks: [BookGridCard] = []
        for id in ids {
            let books = try await getBooksByAuthorUseCase.execute(author: id)
            allBooks.append(contentsOf: books)
        }
        return allBooks
    }

    private func loadMeta() async {
        do {
            async let genresTask = getGenresUseCase.execute()
            async let authorsTask = getAuthorsUseCase.execute()

            genres = try await genresTask
            authors = try await authorsTask

        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Properties
private extension SearchView {
    var filteredBooks: [BookGridCard] {
        books.filter { book in
            let searchLowercased = searchText.lowercased()
            return book.title.lowercased().contains(searchLowercased)
        }
    }
}

// MARK: View Components
private extension SearchView {
    @ViewBuilder
    var genresSection: some View {
        Group {
            if !genres.isEmpty {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Жанры")
                        .h2TextStyle()
                    GenresGridView(genres: genres) { selectedGenre in
                        searchText = selectedGenre.name
                    }
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
            ImageLoader(imageUrlString: author.image)
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
        BookListView(books: books, spacing: 16)
    }
}
