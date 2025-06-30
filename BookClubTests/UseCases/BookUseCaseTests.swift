//
//  BookUseCaseTests.swift
//  BookClubTests
//
//  Created by Test on 22.06.2025.
//

import XCTest
@testable import BookClub

final class BookUseCaseTests: XCTestCase {
    
    // MARK: - Test Data
    
    private func createTestBook(id: Int = 1) -> Book {
        return Book(
            id: id,
            documentId: "doc_\(id)",
            title: "Test Book \(id)",
            coverImageUrl: "https://example.com/cover.jpg",
            authors: [Author(id: 1, name: "Test Author")],
            genres: ["Fiction"],
            description: "Test description"
        )
    }
    
    private func createTestChapter(id: Int = 1, order: Int = 1) -> Chapter {
        return Chapter(
            id: id,
            documentId: "chapter_doc_\(id)",
            title: "Chapter \(id)",
            text: "Chapter text content",
            order: order
        )
    }
    
    // MARK: - GetBooksUseCase Tests
    
    func testGetBooksUseCase_Success() async throws {
        // Arrange
        let mockRepository = MockBookRepository()
        let useCase = GetBooksUseCaseImpl(repository: mockRepository)
        let testBooks = [createTestBook(id: 1), createTestBook(id: 2)]
        mockRepository.mockBooks = testBooks
        
        // Act
        let result = try await useCase.execute(page: 1, pageSize: 10)
        
        // Assert
        XCTAssertEqual(mockRepository.getBooksCallCount, 1)
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].id, 1)
        XCTAssertEqual(result[1].id, 2)
    }
    
    func testGetBooksUseCase_EmptyResult() async throws {
        // Arrange
        let mockRepository = MockBookRepository()
        let useCase = GetBooksUseCaseImpl(repository: mockRepository)
        mockRepository.mockBooks = []
        
        // Act
        let result = try await useCase.execute(page: 1, pageSize: 10)
        
        // Assert
        XCTAssertEqual(mockRepository.getBooksCallCount, 1)
        XCTAssertTrue(result.isEmpty)
    }
    
    func testGetBooksUseCase_Error() async throws {
        // Arrange
        let mockRepository = MockBookRepository()
        let useCase = GetBooksUseCaseImpl(repository: mockRepository)
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = NSError(domain: "test", code: 500)
        
        // Act & Assert
        do {
            _ = try await useCase.execute(page: 1, pageSize: 10)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(mockRepository.getBooksCallCount, 1)
        }
    }
    
    // MARK: - GetBookByIdUseCase Tests
    
    func testGetBookByIdUseCase_Success() async throws {
        // Arrange
        let mockBookRepository = MockBookRepository()
        let mockProgressRepository = MockProgressRepository()
        let mockFavoritesRepository = MockFavoritesRepository()
        let useCase = GetBookByIdUseCaseImpl(
            repository: mockBookRepository,
            progressRepository: mockProgressRepository,
            favoriteRepository: mockFavoritesRepository
        )
        
        let testBook = createTestBook(id: 1)
        let testChapters = [createTestChapter(id: 1, order: 1), createTestChapter(id: 2, order: 2)]
        let testProgress = [Progress(id: 1, updatedAt: Date(), documentId: "doc_1", value: 50, chapterId: 1)]
        
        mockBookRepository.mockBook = testBook
        mockBookRepository.mockChapters = testChapters
        mockProgressRepository.mockProgress = testProgress
        mockFavoritesRepository.mockFavoriteDocumentIds = ["fav_1"]
        
        // Act
        let result = try await useCase.execute(bookId: 1)
        
        // Assert
        XCTAssertEqual(mockBookRepository.getBookByIdCallCount, 1)
        XCTAssertEqual(mockBookRepository.getBookChaptersCallCount, 1)
        XCTAssertEqual(mockProgressRepository.getProgressCallCount, 1)
        XCTAssertEqual(mockFavoritesRepository.getFavoritesByBookIdCallCount, 1)
        
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.title, "Test Book 1")
        XCTAssertEqual(result.chapters.count, 2)
        XCTAssertTrue(result.isFavorite)
        XCTAssertNotNil(result.activeChapter)
        XCTAssertEqual(result.activeChapter?.chapterId, 1)
        XCTAssertEqual(result.activeChapter?.value, 50)
    }
    
    func testGetBookByIdUseCase_NoProgress() async throws {
        // Arrange
        let mockBookRepository = MockBookRepository()
        let mockProgressRepository = MockProgressRepository()
        let mockFavoritesRepository = MockFavoritesRepository()
        let useCase = GetBookByIdUseCaseImpl(
            repository: mockBookRepository,
            progressRepository: mockProgressRepository,
            favoriteRepository: mockFavoritesRepository
        )
        
        let testBook = createTestBook(id: 1)
        let testChapters = [createTestChapter(id: 1, order: 1)]
        
        mockBookRepository.mockBook = testBook
        mockBookRepository.mockChapters = testChapters
        mockProgressRepository.mockProgress = []
        mockFavoritesRepository.mockFavoriteDocumentIds = []
        
        // Act
        let result = try await useCase.execute(bookId: 1)
        
        // Assert
        XCTAssertEqual(result.id, 1)
        XCTAssertFalse(result.isFavorite)
        XCTAssertNil(result.activeChapter)
    }
    
    func testGetBookByIdUseCase_BookNotFound() async throws {
        // Arrange
        let mockBookRepository = MockBookRepository()
        let mockProgressRepository = MockProgressRepository()
        let mockFavoritesRepository = MockFavoritesRepository()
        let useCase = GetBookByIdUseCaseImpl(
            repository: mockBookRepository,
            progressRepository: mockProgressRepository,
            favoriteRepository: mockFavoritesRepository
        )
        
        mockBookRepository.shouldThrowError = true
        mockBookRepository.errorToThrow = NSError(domain: "test", code: 404, userInfo: [NSLocalizedDescriptionKey: "Book not found"])
        
        // Act & Assert
        do {
            _ = try await useCase.execute(bookId: 999)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(mockBookRepository.getBookByIdCallCount, 1)
        }
    }
    
    // MARK: - GetBooksByNameUseCase Tests
    
    func testGetBooksByNameUseCase_Success() async throws {
        // Arrange
        let mockRepository = MockBookRepository()
        let useCase = GetBookByNameUseCaseImpl(repository: mockRepository)
        let testBooks = [createTestBook(id: 1)]
        mockRepository.mockBooks = testBooks
        
        // Act
        let result = try await useCase.execute(name: "Test Book")
        
        // Assert
        XCTAssertEqual(mockRepository.findBooksByNameCallCount, 1)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].title, "Test Book 1")
    }
    
    func testGetBooksByNameUseCase_EmptySearchTerm() async throws {
        // Arrange
        let mockRepository = MockBookRepository()
        let useCase = GetBookByNameUseCaseImpl(repository: mockRepository)
        mockRepository.mockBooks = []
        
        // Act
        let result = try await useCase.execute(name: "")
        
        // Assert
        XCTAssertEqual(mockRepository.findBooksByNameCallCount, 1)
        XCTAssertTrue(result.isEmpty)
    }
    
    // MARK: - GetBooksByGenreUseCase Tests
    
    func testGetBooksByGenreUseCase_Success() async throws {
        // Arrange
        let mockRepository = MockBookRepository()
        let useCase = GetBooksByGenreUseCaseImpl(repository: mockRepository)
        let testBooks = [createTestBook(id: 1), createTestBook(id: 2)]
        mockRepository.mockBooks = testBooks
        
        // Act
        let result = try await useCase.execute(genre: 1)
        
        // Assert
        XCTAssertEqual(mockRepository.getBooksByGenreCallCount, 1)
        XCTAssertEqual(result.count, 2)
    }
    
    // MARK: - GetBooksByAuthorUseCase Tests
    
    func testGetBooksByAuthorUseCase_Success() async throws {
        // Arrange
        let mockRepository = MockBookRepository()
        let useCase = GetBooksByAuthorUseCaseImpl(repository: mockRepository)
        let testBooks = [createTestBook(id: 1)]
        mockRepository.mockBooks = testBooks
        
        // Act
        let result = try await useCase.execute(author: 1)
        
        // Assert
        XCTAssertEqual(mockRepository.getBooksByAuthorCallCount, 1)
        XCTAssertEqual(result.count, 1)
    }
    
    // MARK: - GetNewBooksUseCase Tests
    
    func testGetNewBooksUseCase_Success() async throws {
        // Arrange
        let mockRepository = MockBookRepository()
        let useCase = GetNewBooksUseCaseImpl(repository: mockRepository)
        let testBooks = [createTestBook(id: 1)]
        mockRepository.mockBooks = testBooks
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(mockRepository.getNewBooksCallCount, 1)
        XCTAssertEqual(result.count, 1)
    }
    
    // MARK: - GetBookChaptersUseCase Tests
    
    func testGetBookChaptersUseCase_Success() async throws {
        // Arrange
        let mockRepository = MockBookRepository()
        let useCase = GetBookChaptersUseCaseImpl(repository: mockRepository)
        let testChapters = [createTestChapter(id: 1, order: 1), createTestChapter(id: 2, order: 2)]
        mockRepository.mockChapters = testChapters
        
        // Act
        let result = try await useCase.execute(bookId: 1)
        
        // Assert
        XCTAssertEqual(mockRepository.getBookChaptersCallCount, 1)
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].order, 1)
        XCTAssertEqual(result[1].order, 2)
    }
    
    func testGetBookChaptersUseCase_EmptyChapters() async throws {
        // Arrange
        let mockRepository = MockBookRepository()
        let useCase = GetBookChaptersUseCaseImpl(repository: mockRepository)
        mockRepository.mockChapters = []
        
        // Act
        let result = try await useCase.execute(bookId: 1)
        
        // Assert
        XCTAssertEqual(mockRepository.getBookChaptersCallCount, 1)
        XCTAssertTrue(result.isEmpty)
    }
    
    // MARK: - GetBookCardsUseCase Tests
    
    func testGetBookCardsUseCase_Success() async throws {
        // Arrange
        let mockRepository = MockBookRepository()
        let useCase = GetBookCardsUseCaseImpl(repository: mockRepository)
        let testBooks = [createTestBook(id: 1)]
        mockRepository.mockBooks = testBooks
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(mockRepository.getBooksCallCount, 1)
        XCTAssertEqual(result.count, 1)
    }
} 
