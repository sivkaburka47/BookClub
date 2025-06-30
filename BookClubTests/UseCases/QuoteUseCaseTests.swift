//
//  QuoteUseCaseTests.swift
//  BookClubTests
//
//  Created by Станислав Дейнекин on 30.06.2025.
//

import XCTest
@testable import BookClub

final class QuoteUseCaseTests: XCTestCase {
    
    // MARK: - Test Data
    
    private func createTestQuote(id: Int = 1, bookId: Int = 1) -> Quote {
        return Quote(
            id: id,
            text: "This is a test quote \(id)",
            bookTitle: "Test Book \(bookId)",
            authors: [Author(id: 1, name: "Test Author")],
            bookId: bookId
        )
    }
    
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
    
    // MARK: - GetQuotesUseCase Tests
    
    func testGetQuotesUseCase_Success() async throws {
        // Arrange
        let mockQuoteRepository = MockQuoteRepository()
        let mockBookRepository = MockBookRepository()
        let useCase = GetQuotesUseCaseImpl(
            repository: mockQuoteRepository,
            bookRepository: mockBookRepository
        )
        
        let testQuotes = [createTestQuote(id: 1, bookId: 1), createTestQuote(id: 2, bookId: 2)]
        let testBook = createTestBook(id: 1)
        
        mockQuoteRepository.mockQuotes = testQuotes
        mockBookRepository.mockBook = testBook
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(mockQuoteRepository.getQuotesCallCount, 1)
        XCTAssertGreaterThan(mockBookRepository.getBookByIdCallCount, 0)
        XCTAssertEqual(result.count, testQuotes.count)
    }
    
    func testGetQuotesUseCase_EmptyQuotes() async throws {
        // Arrange
        let mockQuoteRepository = MockQuoteRepository()
        let mockBookRepository = MockBookRepository()
        let useCase = GetQuotesUseCaseImpl(
            repository: mockQuoteRepository,
            bookRepository: mockBookRepository
        )
        
        mockQuoteRepository.mockQuotes = []
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(mockQuoteRepository.getQuotesCallCount, 1)
        XCTAssertEqual(mockBookRepository.getBookByIdCallCount, 0)
        XCTAssertTrue(result.isEmpty)
    }
    
    func testGetQuotesUseCase_RepositoryError() async throws {
        // Arrange
        let mockQuoteRepository = MockQuoteRepository()
        let mockBookRepository = MockBookRepository()
        let useCase = GetQuotesUseCaseImpl(
            repository: mockQuoteRepository,
            bookRepository: mockBookRepository
        )
        
        mockQuoteRepository.shouldThrowError = true
        mockQuoteRepository.errorToThrow = NSError(domain: "test", code: 500)
        
        // Act & Assert
        do {
            _ = try await useCase.execute()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(mockQuoteRepository.getQuotesCallCount, 1)
        }
    }
    
    // MARK: - CreateQuoteUseCase Tests
    
    func testCreateQuoteUseCase_Success() async throws {
        // Arrange
        let mockRepository = MockQuoteRepository()
        let useCase = CreateQuoteUseCaseImpl(repository: mockRepository)
        let testQuote = createTestQuote()
        
        // Act
        try await useCase.execute(quote: testQuote)
        
        // Assert
        XCTAssertEqual(mockRepository.createQuoteCallCount, 1)
        XCTAssertEqual(mockRepository.lastCreatedQuote?.id, testQuote.id)
        XCTAssertEqual(mockRepository.lastCreatedQuote?.text, testQuote.text)
        XCTAssertEqual(mockRepository.lastCreatedQuote?.bookId, testQuote.bookId)
        XCTAssertEqual(mockRepository.lastCreatedQuote?.bookTitle, testQuote.bookTitle)
    }
    
    func testCreateQuoteUseCase_Error() async throws {
        // Arrange
        let mockRepository = MockQuoteRepository()
        let useCase = CreateQuoteUseCaseImpl(repository: mockRepository)
        let testQuote = createTestQuote()
        
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = NSError(domain: "test", code: 500)
        
        // Act & Assert
        do {
            try await useCase.execute(quote: testQuote)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(mockRepository.createQuoteCallCount, 1)
        }
    }
    
    // MARK: - Edge Cases
    
    func testCreateQuoteUseCase_EmptyQuoteText() async throws {
        // Arrange
        let mockRepository = MockQuoteRepository()
        let useCase = CreateQuoteUseCaseImpl(repository: mockRepository)
        let emptyQuote = Quote(
            id: 1,
            text: "",
            bookTitle: "Test Book",
            authors: [Author(id: 1, name: "Test Author")],
            bookId: 1
        )
        
        // Act
        try await useCase.execute(quote: emptyQuote)
        
        // Assert
        XCTAssertEqual(mockRepository.createQuoteCallCount, 1)
        XCTAssertEqual(mockRepository.lastCreatedQuote?.text, "")
    }
    
    func testCreateQuoteUseCase_InvalidBookId() async throws {
        // Arrange
        let mockRepository = MockQuoteRepository()
        let useCase = CreateQuoteUseCaseImpl(repository: mockRepository)
        let invalidQuote = Quote(
            id: 1,
            text: "Test quote",
            bookTitle: "Test Book",
            authors: [Author(id: 1, name: "Test Author")],
            bookId: -1
        )
        
        // Act
        try await useCase.execute(quote: invalidQuote)
        
        // Assert
        XCTAssertEqual(mockRepository.createQuoteCallCount, 1)
        XCTAssertEqual(mockRepository.lastCreatedQuote?.bookId, -1)
    }
    
} 
