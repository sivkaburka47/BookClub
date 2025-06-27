//
//  BookmarksView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct BookmarksView: View {

    let getFavoritesUseCase: GetFavoritesUseCase = GetFavoritesUseCaseImpl.create()
    let getQuotesUseCase: GetQuotesUseCase = GetQuotesUseCaseImpl.create()

    let book = BookDetails(
        image: "book",
        title: "Код Да Винчи",
        author: "bebrik",
        activeChapter: 0,
        chapters: ["Пролог", "Глава 1", "Глава 2", "Глава 3"]
    )
    
    @State private var books: [BookGridCard] = []

    @State private var quotes: [Quote] = []

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
        .task {
            do {
                quotes = try await getQuotesUseCase.execute()
            } catch {
                print(error.localizedDescription)
            }

            do {
                books = try await getFavoritesUseCase.execute()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: View Components
private extension BookmarksView {
    @ViewBuilder
    var currentReadingSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Читаете сейчас")
                    .h2TextStyle()
                    .frame(maxWidth: .infinity, alignment: .leading)
                PlayButton()
            }
            
            NavigationLink(destination: MovieDetailsView()) {
                HStack(spacing: 16) {
                    BookCover(image: book.image)
                    VStack(alignment: .leading, spacing: 16) {
                        bookInfo(for: book)
                        ProgressLine(progress: book.progress)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
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
    
    @ViewBuilder
    var quotesSection: some View {
        Group {
            if !quotes.isEmpty {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Цитаты")
                        .h2TextStyle()
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(quotes) { quote in
                            quoteRow(for: quote)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func quoteRow(for quote: Quote) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(quote.text)
                .quoteTextStyle()
            
            Text("\(quote.bookTitle) • \(quote.authors.map(\.name).joined(separator: ", "))")
                .footnoteTextStyle()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color("AccentLight"))
        .cornerRadius(8)
    }
    
    @ViewBuilder
    func bookInfo(for book: BookDetails) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(book.title)
                .h2TextStyle()
            Text(book.currentChapter)
                .font(Font.custom("VelaSans-Bold", size: 14))
                .bodySmallTextStyle()
        }
    }
    
}
