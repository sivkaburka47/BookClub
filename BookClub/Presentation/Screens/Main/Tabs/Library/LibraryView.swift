//
//  LibraryView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct LibraryView: View {
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible())
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
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Популярные книги")
                            .h2TextStyle()
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(cards) { card in
                                NavigationLink(destination: MovieDetailsView()) {
                                    CardView(cardImage: card.image, title: card.title, authors: card.authors)
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

#Preview {
    LibraryView()
}
