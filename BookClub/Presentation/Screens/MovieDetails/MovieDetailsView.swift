//  MovieDetailsView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 18.03.2025.
//

import SwiftUI

struct MovieDetailsView: View {
    @Environment(\.dismiss) var dismiss

    private let getMovieDetailsUseCase: GetBookByIdUseCase = GetBookByIdUseCaseImpl.create()
    private let removeFromFavoritesUseCase: RemoveFromFavoritesUseCase = RemoveFromFavoritesUseCaseImpl.create()
    private let addToFavoritesUseCase: AddToFavoritesUseCase = AddToFavoritesUseCaseImpl.create()

    @State private var book: BookDetails = BookDetails()
    let bookId: Int

    // MARK: - Init
    init(bookId: Int) {
        self.bookId = bookId
    }

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
        .task {
            do {
                book = try await getMovieDetailsUseCase.execute(bookId: bookId)
            } catch {
                print(error.localizedDescription)
            }
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

private extension MovieDetailsView {
    func toggleFavoriteState() async {
        if book.isFavorite {
            do {
                try await removeFromFavoritesUseCase.execute(bookId: book.id)
                book.isFavorite.toggle()
            } catch {
                print(error.localizedDescription)
            }
        } else {
            do {
                try await addToFavoritesUseCase.execute(bookId: book.id)
                book.isFavorite.toggle()
            } catch {
                print(error.localizedDescription)
            }
        }
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
            
            Button(action: {
                Task {
                    await toggleFavoriteState()
                }
            }, label: {
                StyledButtonContent(text: book.isFavorite ? "Избранное" : "В избранное", icon: "Bookmarks", style: book.isFavorite ? .dark : .light)
            })
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
            Text(book.authors.map { $0 }.joined(separator: ", "))
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
        if !book.chapters.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Text("Оглавление")
                    .h2TextStyle()
                chaptersList
            }
        }
    }
    
    @ViewBuilder
    var chaptersList: some View {
        let activeChapterId = book.activeChapter?.chapterId
        let activeChapterValue = book.activeChapter?.value
        let activeChapterOrder = book.chapters.first(where: { $0.id == activeChapterId })?.order

        VStack(spacing: 0) {
            ForEach(book.chapters) { chapter in
                var isActive = chapter.id == activeChapterId

                let isRead: Bool = {
                    guard let activeOrder = activeChapterOrder else { return false }

                    if chapter.order < activeOrder {
                        return true
                    } else if chapter.order == activeOrder {
                        isActive = false
                        return (activeChapterValue == 100)
                    } else {
                        return false
                    }
                }()

                chapterRow(
                    chapter: chapter.title,
                    isActive: isActive,
                    isRead: isRead
                )
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
