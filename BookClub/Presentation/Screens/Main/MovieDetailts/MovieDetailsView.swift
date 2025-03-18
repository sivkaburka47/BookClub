//
//  MovieDetailsView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 18.03.2025.
//

import SwiftUI

struct MovieDetailsView: View {
    let book = BookDetails(
        image: "bookCoverDetails",
        title: "Код Да Винчи",
        author: "Дэн Браун",
        description: ["Секретный код скрыт в работах Леонардо да Винчи...", "Только он поможет найти христианские святыни, дающие немыслимые власть и могущество...", "Ключ к величайшей тайне, над которой человечество билось веками, наконец может быть найден..."],
        activeChapter: 0,
        chapters: ["Пролог", "Глава 1", "Глава 2", "Глава 3"]
    )
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack (spacing: 0) {
                    BookCoverHeader(image: book.image)
                    ActionButtons()
                }
                .padding(.bottom, -25)
                
                VStack(alignment: .leading, spacing: 25) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ScreenTitle(text: book.title, style: .darkGreen)
                        AdditionalText(text: book.author)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(book.description, id: \.self) { line in
                            AdditionalText(text: line)
                        }
                    }
                    
                    
                    Spacer().frame(height: 100)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            }
            .ignoresSafeArea()
            
        }
    }
}

#Preview {
    MovieDetailsView()
}
