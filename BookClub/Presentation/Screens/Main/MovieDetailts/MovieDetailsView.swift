//
//  MovieDetailsView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 18.03.2025.
//

import SwiftUI

struct MovieDetailsView: View {
    @Environment(\.dismiss) var dismiss
    
    let book = BookDetails(
        image: "bookCoverDetails",
        title: "Код Да Винчи",
        author: "Дэн Браун",
        description: ["Секретный код скрыт в работах Леонардо да Винчи...", "Только он поможет найти христианские святыни, дающие немыслимые власть и могущество...", "Ключ к величайшей тайне, над которой человечество билось веками, наконец может быть найден..."],
        activeChapter: 1,
        chapters: ["Факты", "Пролог", "Глава 1", "Глава 2", "Глава 3", "Глава 4", "Глава 5", "Глава 6", "Глава 7"]
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
                        Text(book.title)
                            .h1TextStyle()
                            .foregroundColor(Color("AccentDark"))
                        Text(book.author)
                            .bodyTextStyle()
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(book.description, id: \.self) { line in
                            Text(line)
                                .bodyTextStyle()
                        }
                    }
                    
                    if book.activeChapter != nil {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Прочитано")
                                .h2TextStyle()
                            ProgressLine(progress: book.progress)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Оглавление")
                            .h2TextStyle()
                        ChaptersList(chapters: book.chapters, activeChapter: book.activeChapter)
                    }
                    
                    Spacer().frame(height: 100)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            }
            .ignoresSafeArea()
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton(dismiss: dismiss, style: .light)
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

#Preview {
    MovieDetailsView()
}
