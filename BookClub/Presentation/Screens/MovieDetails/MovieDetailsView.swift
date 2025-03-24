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
        description: ["Секретный код скрыт в работах Леонардо да Винчи...", "Только он поможет найти христианские святыни, дающие немыслимые власть и могущество...", "Ключ к величайшей тайне, над которой человечество билось веками, наконец может быть найден..."],
        activeChapter: 3,
        chapters: ["Факты", "Пролог", "Глава 1", "Глава 2", "Глава 3", "Глава 4", "Глава 5", "Глава 6", "Глава 7"]
    )
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                headerSection
                contentSection
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

// MARK: View Components
private extension MovieDetailsView {
    @ViewBuilder
    var headerSection: some View {
        VStack(spacing: 0) {
            BookCoverHeader(image: book.image)
            actionButtons
        }
        .padding(.bottom, -25)
    }
    
    @ViewBuilder
    var contentSection: some View {
        VStack(alignment: .leading, spacing: 25) {
            titleAndAuthor
            descriptionSection
            progressSection
            chaptersSection
            Spacer().frame(height: 100)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    var actionButtons: some View {
        HStack(spacing: 8) {
            NavigationLink(destination: ChapterView()) {
                StyledButtonContent(text: "Читать", icon: "Play", style: .dark)
            }
            
            Button(action: {}) {
                StyledButtonContent(text: "В избранное", icon: "Bookmarks", style: .light)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .offset(y: -25)
    }
    
    @ViewBuilder
    var titleAndAuthor: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(book.title)
                .h1TextStyle()
                .foregroundColor(Color("AccentDark"))
            Text(book.author)
                .bodyTextStyle()
        }
    }
    
    @ViewBuilder
    var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(book.description, id: \.self) { line in
                Text(line)
                    .bodyTextStyle()
            }
        }
    }
    
    @ViewBuilder
    var progressSection: some View {
        if book.activeChapter != nil {
            VStack(alignment: .leading, spacing: 16) {
                Text("Прочитано")
                    .h2TextStyle()
                ProgressLine(progress: book.progress)
            }
        }
    }
    
    @ViewBuilder
    var chaptersSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Оглавление")
                .h2TextStyle()
            chaptersList
        }
    }
    
    @ViewBuilder
    var chaptersList: some View {
        VStack(spacing: 0) {
            ForEach(book.chapters.indices, id: \.self) { index in
                chapterRow(chapter: book.chapters[index],
                            isActive: book.activeChapter == index,
                            isRead: book.activeChapter != nil && index < book.activeChapter!)
            }
        }
    }
    
    @ViewBuilder
    func chapterRow(chapter: String, isActive: Bool, isRead: Bool) -> some View {
        HStack {
            Text(chapter)
                .font(.custom(isActive ? "VelaSans-Bold" : "VelaSans-Regular", size: 16))
                .bodyTextStyle()
                .frame(maxWidth: .infinity, alignment: .leading)
                
            if isActive {
                NavigationLink(destination: ChapterView()) {
                    CustomIcon(name: "ReadingNow", size: 24, color: Color("AccentDark"))
                }
            } else if isRead {
                CustomIcon(name: "Read", size: 24, color: Color("AccentMedium"))
            }
        }
        .padding(.vertical, 8)
    }
    
}

#Preview {
    MovieDetailsView()
}
