//
//  DomainModelsTests.swift
//  BookClubTests
//
//  Created by Test on 22.06.2025.
//

import XCTest
@testable import BookClub

final class DomainModelsTests: XCTestCase {
    
    // MARK: - Book Tests
    
    func testBook_Initialization() {
        // Arrange & Act
        let book = Book(
            id: 1,
            documentId: "doc_1",
            title: "Test Book",
            coverImageUrl: "https://example.com/cover.jpg",
            createdAt: Date(),
            updatedAt: Date(),
            publishedAt: Date(),
            isNew: true,
            authors: [Author(id: 1, name: "Test Author")],
            genres: ["Fiction"],
            description: "Test description"
        )
        
        // Assert
        XCTAssertEqual(book.id, 1)
        XCTAssertEqual(book.title, "Test Book")
        XCTAssertEqual(book.authors.count, 1)
        XCTAssertEqual(book.genres.count, 1)
        XCTAssertTrue(book.isNew)
    }
    
    func testBook_DefaultInitialization() {
        // Arrange & Act
        let book = Book()
        
        // Assert
        XCTAssertEqual(book.id, 0)
        XCTAssertEqual(book.title, "")
        XCTAssertTrue(book.authors.isEmpty)
        XCTAssertTrue(book.genres.isEmpty)
        XCTAssertFalse(book.isNew)
    }
    
    func testBook_ToFeaturedBookCard() {
        // Arrange
        let book = Book(
            id: 1,
            title: "Test Book",
            coverImageUrl: "https://example.com/cover.jpg",
            description: "Test description"
        )
        
        // Act
        let featuredCard = book.toFeaturedBookCard()
        
        // Assert
        XCTAssertEqual(featuredCard.id, 1)
        XCTAssertEqual(featuredCard.title, "Test Book")
        XCTAssertEqual(featuredCard.image, "https://example.com/cover.jpg")
        XCTAssertEqual(featuredCard.description, "Test description")
    }
    
    func testBook_ToFeaturedBookCard_NilCoverAndDescription() {
        // Arrange
        let book = Book(
            id: 1,
            title: "Test Book",
            coverImageUrl: nil,
            description: nil
        )
        
        // Act
        let featuredCard = book.toFeaturedBookCard()
        
        // Assert
        XCTAssertEqual(featuredCard.id, 1)
        XCTAssertEqual(featuredCard.image, "https://litclubbs.ru/news/3899-novaja-zaglushka-dlja-oblozhek.html")
        XCTAssertEqual(featuredCard.description, "Описание отсутствует")
    }
    
    func testBook_ToBookGridCard() {
        // Arrange
        let authors = [Author(id: 1, name: "Test Author")]
        let book = Book(
            id: 1,
            title: "Test Book",
            coverImageUrl: "https://example.com/cover.jpg",
            authors: authors
        )
        
        // Act
        let gridCard = book.toBookGridCard()
        
        // Assert
        XCTAssertEqual(gridCard.id, 1)
        XCTAssertEqual(gridCard.title, "Test Book")
        XCTAssertEqual(gridCard.image, "https://example.com/cover.jpg")
        XCTAssertEqual(gridCard.authors.count, 1)
        XCTAssertEqual(gridCard.authors[0].name, "Test Author")
    }
    
    // MARK: - BookDetails Tests
    
    func testBookDetails_Initialization() {
        // Arrange & Act
        let chapters = [
            Chapter(id: 1, title: "Chapter 1", order: 1),
            Chapter(id: 2, title: "Chapter 2", order: 2)
        ]
        
        let bookDetails = BookDetails(
            id: 1,
            documentId: "doc_1",
            image: "https://example.com/cover.jpg",
            title: "Test Book",
            authors: ["Author One", "Author Two"],
            description: ["Description line 1", "Description line 2"],
            activeChapter: (chapterId: 1, value: 50),
            chapters: chapters,
            isFavorite: true
        )
        
        // Assert
        XCTAssertEqual(bookDetails.id, 1)
        XCTAssertEqual(bookDetails.title, "Test Book")
        XCTAssertEqual(bookDetails.authors.count, 2)
        XCTAssertEqual(bookDetails.chapters.count, 2)
        XCTAssertTrue(bookDetails.isFavorite)
        XCTAssertNotNil(bookDetails.activeChapter)
    }
    
    func testBookDetails_CurrentChapter() {
        // Arrange
        let chapters = [
            Chapter(id: 1, title: "Chapter 1", order: 1),
            Chapter(id: 2, title: "Chapter 2", order: 2)
        ]
        
        let bookDetails = BookDetails(
            activeChapter: (chapterId: 2, value: 50),
            chapters: chapters
        )
        
        // Act
        let currentChapter = bookDetails.currentChapter
        
        // Assert
        XCTAssertEqual(currentChapter.id, 2)
        XCTAssertEqual(currentChapter.title, "Chapter 2")
    }
    
    func testBookDetails_CurrentChapter_NoActiveChapter() {
        // Arrange
        let chapters = [Chapter(id: 1, title: "Chapter 1")]
        let bookDetails = BookDetails(chapters: chapters)
        
        // Act
        let currentChapter = bookDetails.currentChapter
        
        // Assert
        XCTAssertEqual(currentChapter.id, 0)
        XCTAssertEqual(currentChapter.title, "Неизвестная глава")
        XCTAssertEqual(currentChapter.text, "Текст отсутствует")
    }
    
    func testBookDetails_Progress() {
        // Arrange
        let chapters = [
            Chapter(id: 1, title: "Chapter 1", order: 1),
            Chapter(id: 2, title: "Chapter 2", order: 2),
            Chapter(id: 3, title: "Chapter 3", order: 3)
        ]
        
        let bookDetails = BookDetails(
            activeChapter: (chapterId: 2, value: 50),
            chapters: chapters
        )
        
        // Act
        let progress = bookDetails.progress
        
        // Assert
        XCTAssertEqual(progress, 2.0/3.0, accuracy: 0.001) // Chapter 2 of 3 = 2/3
    }
    
    func testBookDetails_Progress_NoActiveChapter() {
        // Arrange
        let chapters = [Chapter(id: 1, title: "Chapter 1")]
        let bookDetails = BookDetails(chapters: chapters)
        
        // Act
        let progress = bookDetails.progress
        
        // Assert
        XCTAssertEqual(progress, 0.0)
    }
    
    func testBookDetails_Progress_EmptyChapters() {
        // Arrange
        let bookDetails = BookDetails(
            activeChapter: (chapterId: 1, value: 50),
            chapters: []
        )
        
        // Act
        let progress = bookDetails.progress
        
        // Assert
        XCTAssertEqual(progress, 0.0)
    }
    
    // MARK: - Credentials Tests
    
    func testCredentials_Initialization() {
        // Arrange & Act
        let credentials = Credentials(email: "test@example.com", password: "password123")
        
        // Assert
        XCTAssertEqual(credentials.email, "test@example.com")
        XCTAssertEqual(credentials.password, "password123")
    }
    
    func testCredentials_DefaultInitialization() {
        // Arrange & Act
        let credentials = Credentials()
        
        // Assert
        XCTAssertEqual(credentials.email, "")
        XCTAssertEqual(credentials.password, "")
    }
    
    // MARK: - Progress Tests
    
    func testProgress_Initialization() {
        // Arrange & Act
        let date = Date()
        let progress = Progress(
            id: 1,
            updatedAt: date,
            documentId: "doc_1",
            value: 75,
            chapterId: 2
        )
        
        // Assert
        XCTAssertEqual(progress.id, 1)
        XCTAssertEqual(progress.updatedAt, date)
        XCTAssertEqual(progress.documentId, "doc_1")
        XCTAssertEqual(progress.value, 75)
        XCTAssertEqual(progress.chapterId, 2)
    }
    
    // MARK: - ReadingStatus Tests
    
    func testReadingStatus_NormalizedProgress() {
        // Arrange & Act
        let readingStatus1 = ReadingStatus(
            id: 1,
            bookId: 1,
            bookTitle: "Test Book",
            bookImageUrl: "https://example.com/cover.jpg",
            chapterTitle: "Test Chapter",
            value: 50.0
        )
        
        let readingStatus2 = ReadingStatus(
            id: 2,
            bookId: 2,
            bookTitle: "Test Book 2",
            bookImageUrl: "https://example.com/cover2.jpg",
            chapterTitle: "Test Chapter 2",
            value: 150.0
        )
        
        let readingStatus3 = ReadingStatus(
            id: 3,
            bookId: 3,
            bookTitle: "Test Book 3",
            bookImageUrl: "https://example.com/cover3.jpg",
            chapterTitle: "Test Chapter 3",
            value: -10.0
        )
        
        // Assert
        XCTAssertEqual(readingStatus1.normalizedProgress, 0.5, accuracy: 0.001)
        XCTAssertEqual(readingStatus2.normalizedProgress, 1.0, accuracy: 0.001)
        XCTAssertEqual(readingStatus3.normalizedProgress, 0.0, accuracy: 0.001)
    }
    
    // MARK: - Author Tests
    
    func testAuthor_Initialization() {
        // Arrange & Act
        let author = Author(id: 1, image: "author.jpg", name: "Test Author")
        
        // Assert
        XCTAssertEqual(author.id, 1)
        XCTAssertEqual(author.image, "author.jpg")
        XCTAssertEqual(author.name, "Test Author")
    }
    
    func testAuthor_DefaultInitialization() {
        // Arrange & Act
        let author = Author()
        
        // Assert
        XCTAssertEqual(author.id, 0)
        XCTAssertEqual(author.image, "book")
        XCTAssertEqual(author.name, "Неизвестный автор")
    }
    
    // MARK: - Genre Tests
    
    func testGenre_Initialization() {
        // Arrange & Act
        let genre = Genre(id: 1, name: "Fantasy")
        
        // Assert
        XCTAssertEqual(genre.id, 1)
        XCTAssertEqual(genre.name, "Fantasy")
    }
    
    func testGenre_Hashable() {
        // Arrange
        let genre1 = Genre(id: 1, name: "Fantasy")
        let genre2 = Genre(id: 1, name: "Fantasy")
        let genre3 = Genre(id: 2, name: "Sci-Fi")
        
        // Act & Assert
        XCTAssertEqual(genre1, genre2)
        XCTAssertNotEqual(genre1, genre3)
        
        let set = Set([genre1, genre2, genre3])
        XCTAssertEqual(set.count, 2) // Should only contain unique genres
    }
    
    // MARK: - Chapter Tests
    
    func testChapter_Initialization() {
        // Arrange & Act
        let chapter = Chapter(
            id: 1,
            documentId: "doc_1",
            title: "Chapter 1",
            text: "This is chapter text",
            order: 1
        )
        
        // Assert
        XCTAssertEqual(chapter.id, 1)
        XCTAssertEqual(chapter.documentId, "doc_1")
        XCTAssertEqual(chapter.title, "Chapter 1")
        XCTAssertEqual(chapter.text, "This is chapter text")
        XCTAssertEqual(chapter.order, 1)
    }
    
    func testChapter_DefaultInitialization() {
        // Arrange & Act
        let chapter = Chapter()
        
        // Assert
        XCTAssertEqual(chapter.id, 0)
        XCTAssertEqual(chapter.documentId, "")
        XCTAssertEqual(chapter.title, "")
        XCTAssertEqual(chapter.text, "")
        XCTAssertEqual(chapter.order, 0)
    }
    
    // MARK: - Quote Tests
    
    func testQuote_Initialization() {
        // Arrange & Act
        let authors = [Author(id: 1, name: "Test Author")]
        let quote = Quote(
            id: 1,
            text: "This is a test quote",
            bookTitle: "Test Book",
            authors: authors,
            bookId: 1
        )
        
        // Assert
        XCTAssertEqual(quote.id, 1)
        XCTAssertEqual(quote.text, "This is a test quote")
        XCTAssertEqual(quote.bookTitle, "Test Book")
        XCTAssertEqual(quote.authors.count, 1)
        XCTAssertEqual(quote.bookId, 1)
    }
    
    func testQuote_DefaultInitialization() {
        // Arrange & Act
        let quote = Quote()
        
        // Assert
        XCTAssertEqual(quote.id, 0)
        XCTAssertEqual(quote.text, "")
        XCTAssertEqual(quote.bookTitle, "")
        XCTAssertTrue(quote.authors.isEmpty)
        XCTAssertEqual(quote.bookId, 0)
    }
    
    // MARK: - BookGridCard Tests
    
    func testBookGridCard_Initialization() {
        // Arrange & Act
        let authors = [Author(id: 1, name: "Test Author")]
        let bookGridCard = BookGridCard(
            id: 1,
            image: "https://example.com/cover.jpg",
            title: "Test Book",
            authors: authors
        )
        
        // Assert
        XCTAssertEqual(bookGridCard.id, 1)
        XCTAssertEqual(bookGridCard.image, "https://example.com/cover.jpg")
        XCTAssertEqual(bookGridCard.title, "Test Book")
        XCTAssertEqual(bookGridCard.authors.count, 1)
    }
    
    func testBookGridCard_DefaultInitialization() {
        // Arrange & Act
        let bookGridCard = BookGridCard()
        
        // Assert
        XCTAssertEqual(bookGridCard.id, 0)
        XCTAssertEqual(bookGridCard.image, "")
        XCTAssertEqual(bookGridCard.title, "")
        XCTAssertTrue(bookGridCard.authors.isEmpty)
    }
} 
