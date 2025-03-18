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
        author: "bebrik",
        activeChapter: 0,
        chapters: ["Пролог", "Глава 1", "Глава 2", "Глава 3"]
    )
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack (spacing: 0) {
                        BookCoverHeader(image: book.image)
                        ActionButtons()
                    }
                    
                    Spacer().frame(height: 100)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .ignoresSafeArea()
            
        }
    }
}

#Preview {
    MovieDetailsView()
}
