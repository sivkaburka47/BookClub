//
//  LibraryView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct LibraryView: View {

    let getBookCardsUseCase: GetBookCardsUseCase = GetBookCardsUseCaseImpl.create()
    let getNewBooksUseCase: GetNewBooksUseCase = GetNewBooksUseCaseImpl.create()

    @State private var scrollPosition: Int?
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible())
    ]

    @State private var newBooks: [FeaturedBookCard] = []
    @State private var popularBooks: [BookGridCard] = []
    @State private var isLoading: Bool = false

    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Библиотека")
                        .h1TextStyle()
                        .foregroundColor(Color("Secondary"))
                    
                    if !newBooks.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Новинки")
                                .h2TextStyle()

                            CardCarouselView(cards: newBooks)
                        }
                    }

                    if !popularBooks.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Популярные книги")
                                .h2TextStyle()

                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(popularBooks) { card in
                                    NavigationLink(destination: MovieDetailsView(bookId: card.id)) {
                                        cardView(cardImage: card.image, title: card.title, authors: card.authors)
                                    }
                                }
                            }
                        }
                    }
                    Spacer().frame(height: 100)
                }
                .padding(.horizontal, 16)
            }
            .refreshable {
                await loadBooks()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await loadBooks()
        }
    }
}

private extension LibraryView {
    private func loadBooks() async {
        isLoading = true
        do {
            async let newBooksTask = getNewBooksUseCase.execute()
            async let popularBooksTask = getBookCardsUseCase.execute()

            newBooks = try await newBooksTask
            popularBooks = try await popularBooksTask

        } catch {
            print(error.localizedDescription)
        }
        isLoading = false
    }
}

// MARK: View Components
private extension LibraryView {
    
    @ViewBuilder
    func imageText(description: String?, title: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(description ?? "")
                .foregroundColor(Color("White"))
                .bodySmallTextStyle()
                .lineLimit(2)
            
            Text(title)
                .foregroundColor(Color("White"))
                .h2TextStyle()
                .lineLimit(2)
            
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    func cardView(cardImage: String, title: String, authors: [Author]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            imageSection(imageName: cardImage)
            textContentSection(title: title, authors: authors)
            Spacer()
        }
    }
    
    @ViewBuilder
    func imageSection(imageName: String) -> some View {
        ImageLoader(imageUrlString: imageName)
            .aspectRatio(contentMode: .fit)
            .clipped()
            .cornerRadius(4)
    }
    
    @ViewBuilder
    func textContentSection(title: String, authors: [Author]) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            titleLabel(text: title)
            authorsLabel(authors: authors)
        }
    }
    
    @ViewBuilder
    func titleLabel(text: String) -> some View {
        Text(text)
            .font(Font.custom("AlumniSans-Bold", size: 14))
            .foregroundColor(Color("AccentDark"))
            .textCase(.uppercase)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func authorsLabel(authors: [Author]) -> some View {
        Text(authors.map { $0.name }.joined(separator: ", "))
            .footnoteTextStyle()
            .frame(maxWidth: .infinity, alignment: .leading)
    }

}

#Preview {
    LibraryView()
}
