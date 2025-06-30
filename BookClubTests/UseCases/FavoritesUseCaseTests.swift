//
//  FavoritesUseCaseTests.swift
//  BookClubTests
//
//  Created by Станислав Дейнекин on 30.06.2025.
//

import XCTest
@testable import BookClub

final class FavoritesUseCaseTests: XCTestCase {
    
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
    
    // MARK: - GetFavoritesUseCase Tests
    
    func testGetFavoritesUseCase_Success() async throws {
        // Arrange
        let mockFavoritesRepository = MockFavoritesRepository()
        let mockBookRepository = MockBookRepository()
        let useCase = GetFavoritesUseCaseImpl(
            favoriteRepository: mockFavoritesRepository,
            bookRepository: mockBookRepository
        )
        
        let testBooks = [createTestBook(id: 1), createTestBook(id: 2)]
        mockFavoritesRepository.mockFavoriteIds = [1, 2]
        mockBookRepository.mockBook = testBooks[0]
        
        var callCount = 0
        mockBookRepository.mockBook = nil
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(mockFavoritesRepository.getFavoritesCallCount, 1)
        XCTAssertGreaterThan(mockBookRepository.getBookByIdCallCount, 0)
    }
    
    func testGetFavoritesUseCase_EmptyFavorites() async throws {
        // Arrange
        let mockFavoritesRepository = MockFavoritesRepository()
        let mockBookRepository = MockBookRepository()
        let useCase = GetFavoritesUseCaseImpl(
            favoriteRepository: mockFavoritesRepository,
            bookRepository: mockBookRepository
        )
        
        mockFavoritesRepository.mockFavoriteIds = []
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(mockFavoritesRepository.getFavoritesCallCount, 1)
        XCTAssertEqual(mockBookRepository.getBookByIdCallCount, 0)
        XCTAssertTrue(result.isEmpty)
    }
    
    func testGetFavoritesUseCase_RepositoryError() async throws {
        // Arrange
        let mockFavoritesRepository = MockFavoritesRepository()
        let mockBookRepository = MockBookRepository()
        let useCase = GetFavoritesUseCaseImpl(
            favoriteRepository: mockFavoritesRepository,
            bookRepository: mockBookRepository
        )
        
        mockFavoritesRepository.shouldThrowError = true
        mockFavoritesRepository.errorToThrow = NSError(domain: "test", code: 500)
        
        // Act & Assert
        do {
            _ = try await useCase.execute()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(mockFavoritesRepository.getFavoritesCallCount, 1)
        }
    }
    
    func testGetFavoritesUseCase_BookFetchFailure() async throws {
        // Arrange
        let mockFavoritesRepository = MockFavoritesRepository()
        let mockBookRepository = MockBookRepository()
        let useCase = GetFavoritesUseCaseImpl(
            favoriteRepository: mockFavoritesRepository,
            bookRepository: mockBookRepository
        )
        
        mockFavoritesRepository.mockFavoriteIds = [1, 2, 3]
        mockBookRepository.shouldThrowError = true
        mockBookRepository.errorToThrow = NSError(domain: "test", code: 404)
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(mockFavoritesRepository.getFavoritesCallCount, 1)
        // Should handle failures gracefully and return empty array if all books fail to fetch
        XCTAssertTrue(result.isEmpty)
    }
    
    // MARK: - AddToFavoritesUseCase Tests
    
    func testAddToFavoritesUseCase_Success() async throws {
        // Arrange
        let mockRepository = MockFavoritesRepository()
        let useCase = AddToFavoritesUseCaseImpl(repository: mockRepository)
        let bookId = 123
        
        // Act
        try await useCase.execute(bookId: bookId)
        
        // Assert
        XCTAssertEqual(mockRepository.addToFavoritesCallCount, 1)
        XCTAssertTrue(mockRepository.mockFavoriteIds.contains(bookId))
    }
    
    func testAddToFavoritesUseCase_Error() async throws {
        // Arrange
        let mockRepository = MockFavoritesRepository()
        let useCase = AddToFavoritesUseCaseImpl(repository: mockRepository)
        let bookId = 123
        
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = NSError(domain: "test", code: 500)
        
        // Act & Assert
        do {
            try await useCase.execute(bookId: bookId)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(mockRepository.addToFavoritesCallCount, 1)
        }
    }

    
    // MARK: - Edge Cases
    
    func testAddToFavoritesUseCase_InvalidBookId() async throws {
        // Arrange
        let mockRepository = MockFavoritesRepository()
        let useCase = AddToFavoritesUseCaseImpl(repository: mockRepository)
        let invalidBookId = -1
        
        // Act
        try await useCase.execute(bookId: invalidBookId)
        
        // Assert
        XCTAssertEqual(mockRepository.addToFavoritesCallCount, 1)
        XCTAssertTrue(mockRepository.mockFavoriteIds.contains(invalidBookId))
    }
} 
