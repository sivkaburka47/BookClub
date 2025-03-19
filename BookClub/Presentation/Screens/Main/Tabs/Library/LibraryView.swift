//
//  LibraryView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct LibraryView: View {
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let cards: [BookCard] = [
        BookCard(image: "Cover_1", title: "Понедельник начинается в субботу", author: "Эрик Мария Ремарк"),
        BookCard(image: "Cover_2", title: "Мастер и Маргарита", author: "Михаил Булгаков"),
        BookCard(image: "Cover_3", title: "Преступление и наказание", author: "Фёдор Достоевский"),
        BookCard(image: "Cover_2", title: "Три товарища", author: "Эрих Мария Ремарк"),
        BookCard(image: "Cover_1", title: "Маленький принц", author: "Антуан де Сент-Экзюпери"),
        BookCard(image: "Cover_1", title: "Понедельник начинается в субботу", author: "Эрик Мария Ремарк"),
        BookCard(image: "Cover_2", title: "Мастер и Маргарита", author: "Михаил Булгаков"),
        BookCard(image: "Cover_3", title: "Преступление и наказание", author: "Фёдор Достоевский"),
        BookCard(image: "Cover_2", title: "Три товарища", author: "Эрих Мария Ремарк"),
        BookCard(image: "Cover_1", title: "Маленький принц", author: "Антуан де Сент-Экзюпери"),
        BookCard(image: "Cover_1", title: "Понедельник начинается в субботу", author: "Эрик Мария Ремарк"),
        BookCard(image: "Cover_2", title: "Мастер и Маргарита", author: "Михаил Булгаков"),
        BookCard(image: "Cover_3", title: "Преступление и наказание", author: "Фёдор Достоевский"),
        BookCard(image: "Cover_2", title: "Три товарища", author: "Эрих Мария Ремарк"),
        BookCard(image: "Cover_1", title: "Маленький принц", author: "Антуан де Сент-Экзюпери"),
        BookCard(image: "Cover_2", title: "Сто лет одиночества", author: "Габриэль Гарсиа Маркес"),
        BookCard(image: "Cover_3", title: "Преступление и наказание", author: "Фёдор Достоевский")
    ]
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading){
                    ScreenTitle(text: "Библиотека", style: .red)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        SectionTitle(text: "Новинки")
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        SectionTitle(text: "Популярные книги")
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(cards) { card in
                                NavigationLink(destination: MovieDetailsView()) {
                                    CardView(cardImage: card.image, title: card.title, author: card.author)
                                }
                            }
                        }
                    }
                    
                    
                    Spacer().frame(height: 100)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    LibraryView()
}
