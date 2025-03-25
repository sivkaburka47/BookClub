//
//  LibraryView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct LibraryView: View {
    @State private var scrollPosition: Int?
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible())
    ]
    
    let carouselCards: [BookCard] = [
        BookCard(image: "Cover_4", title: "Рассвет хайпа", authors: ["Эрик Мария Ремарк"], description: "Долгожданное продолжение Голодных игр"),
        BookCard(image: "bookCoverDetails", title: "Хайп окончен", authors: ["Эрик Мария Ремарк"], description: "НеДолгожданное продолжение Голодных игр"),
        BookCard(image: "Cover_1", title: "Дедлайн близко", authors: ["Эрик Мария Ремарк"], description: "Долгожданное продолжение Голодных игр"),
        BookCard(image: "Cover_2", title: "Крутая история", authors: ["Эрик Мария Ремарк"], description: "Долгожданное окончание Голодных игр")
    ]
    
    let cards: [BookCard] = [
        BookCard(image: "Cover_1", title: "Понедельник начинается в субботу", authors: ["Эрик Мария Ремарк"]),
        BookCard(image: "Cover_2", title: "Мастер и Маргарита", authors: ["Михаил Булгаков", "Эрик Мария Ремарк"]),
        BookCard(image: "Cover_3", title: "Преступление и наказание", authors: ["Фёдор Достоевский"]),
        BookCard(image: "Cover_1", title: "Понедельник начинается в субботу", authors: ["Эрик Мария Ремарк"]),
        BookCard(image: "Cover_2", title: "Мастер и Маргарита", authors: ["Михаил Булгаков"]),
        BookCard(image: "Cover_3", title: "Преступление и наказание", authors: ["Фёдор Достоевский"]),
        BookCard(image: "Cover_1", title: "Понедельник начинается в субботу", authors: ["Эрик Мария Ремарк"]),
        BookCard(image: "Cover_2", title: "Мастер и Маргарита", authors: ["Михаил Булгаков"]),
        BookCard(image: "Cover_3", title: "Преступление и наказание", authors: ["Фёдор Достоевский", "Эрик Мария Ремарк"])
    ]
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24){
                    Text("Библиотека")
                        .h1TextStyle()
                        .foregroundColor(Color("Secondary"))
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Новинки")
                            .h2TextStyle()
                        
                        carouselCovers
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Популярные книги")
                            .h2TextStyle()
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(cards) { card in
                                NavigationLink(destination: MovieDetailsView()) {
                                    cardView(cardImage: card.image, title: card.title, authors: card.authors)
                                }
                            }
                        }
                    }
                    Spacer().frame(height: 100)
                }
                .padding(.horizontal, 16)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: View Components
private extension LibraryView {
    @ViewBuilder
    var carouselCovers: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(0..<carouselCards.count, id: \.self) { index in
                        let card = carouselCards[index]
                        
                        ZStack(alignment: .bottomLeading) {
                            Image(card.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width - 112, height: 256)
                                .clipped()
                                .cornerRadius(4)
                            
                            imageText(description: card.description, title: card.title)
                            .padding(.bottom, 16)
                        }
                        .frame(width: geometry.size.width - 112, height: 256)
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, 56)
            }
            .scrollTargetBehavior(.viewAligned)
        }
        .frame(height: 256)
    }
    
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
    func cardView(cardImage: String, title: String, authors: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            imageSection(imageName: cardImage)
            textContentSection(title: title, authors: authors)
            Spacer()
        }
    }
    
    @ViewBuilder
    func imageSection(imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipped()
            .cornerRadius(4)
    }
    
    @ViewBuilder
    func textContentSection(title: String, authors: [String]) -> some View {
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
    func authorsLabel(authors: [String]) -> some View {
        Text(authors.joined(separator: ", "))
            .footnoteTextStyle()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}


#Preview {
    LibraryView()
}
