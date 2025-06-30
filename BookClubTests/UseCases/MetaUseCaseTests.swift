//
//  MetaUseCaseTests.swift
//  BookClubTests
//
//  Created by Станислав Дейнекин on 30.06.2025.
//

import XCTest
@testable import BookClub

final class MetaUseCaseTests: XCTestCase {
    
    // MARK: - Test Data
    
    private func createTestAuthors() -> [Author] {
        return [
            Author(id: 1, image: "author1.jpg", name: "Автор Один"),
            Author(id: 2, image: "author2.jpg", name: "Автор Два"),
            Author(id: 3, image: "author3.jpg", name: "Автор Три")
        ]
    }
    
    private func createTestGenres() -> [Genre] {
        return [
            Genre(id: 1, name: "Фантастика"),
            Genre(id: 2, name: "Детектив"),
            Genre(id: 3, name: "Роман"),
            Genre(id: 4, name: "Приключения")
        ]
    }
    
    // MARK: - GetAuthorsUseCase Tests
    
    func testGetAuthorsUseCase_Success() async throws {
        // Arrange
        let mockRepository = MockMetaRepository()
        let useCase = GetAuthorsUseCaseImpl(repository: mockRepository)
        let testAuthors = createTestAuthors()
        
        mockRepository.mockAuthors = testAuthors
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(mockRepository.getAuthorsCallCount, 1)
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0].id, 1)
        XCTAssertEqual(result[0].name, "Автор Один")
        XCTAssertEqual(result[1].id, 2)
        XCTAssertEqual(result[1].name, "Автор Два")
        XCTAssertEqual(result[2].id, 3)
        XCTAssertEqual(result[2].name, "Автор Три")
    }
    
    func testGetAuthorsUseCase_EmptyResult() async throws {
        // Arrange
        let mockRepository = MockMetaRepository()
        let useCase = GetAuthorsUseCaseImpl(repository: mockRepository)
        
        mockRepository.mockAuthors = []
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(mockRepository.getAuthorsCallCount, 1)
        XCTAssertTrue(result.isEmpty)
    }
    
    func testGetAuthorsUseCase_Error() async throws {
        // Arrange
        let mockRepository = MockMetaRepository()
        let useCase = GetAuthorsUseCaseImpl(repository: mockRepository)
        
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = NSError(domain: "test", code: 500, userInfo: [NSLocalizedDescriptionKey: "Server error"])
        
        // Act & Assert
        do {
            _ = try await useCase.execute()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(mockRepository.getAuthorsCallCount, 1)
            XCTAssertEqual((error as NSError).domain, "test")
            XCTAssertEqual((error as NSError).code, 500)
        }
    }
    
    // MARK: - GetGenresUseCase Tests
    
    func testGetGenresUseCase_Success() async throws {
        // Arrange
        let mockRepository = MockMetaRepository()
        let useCase = GetGenresUseCaseImpl(repository: mockRepository)
        let testGenres = createTestGenres()
        
        mockRepository.mockGenres = testGenres
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(mockRepository.getGenresCallCount, 1)
        XCTAssertEqual(result.count, 4)
        XCTAssertEqual(result[0].id, 1)
        XCTAssertEqual(result[0].name, "Фантастика")
        XCTAssertEqual(result[1].id, 2)
        XCTAssertEqual(result[1].name, "Детектив")
        XCTAssertEqual(result[2].id, 3)
        XCTAssertEqual(result[2].name, "Роман")
        XCTAssertEqual(result[3].id, 4)
        XCTAssertEqual(result[3].name, "Приключения")
    }
    
    func testGetGenresUseCase_EmptyResult() async throws {
        // Arrange
        let mockRepository = MockMetaRepository()
        let useCase = GetGenresUseCaseImpl(repository: mockRepository)
        
        mockRepository.mockGenres = []
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(mockRepository.getGenresCallCount, 1)
        XCTAssertTrue(result.isEmpty)
    }
    
    func testGetGenresUseCase_Error() async throws {
        // Arrange
        let mockRepository = MockMetaRepository()
        let useCase = GetGenresUseCaseImpl(repository: mockRepository)
        
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = NSError(domain: "test", code: 404, userInfo: [NSLocalizedDescriptionKey: "Not found"])
        
        // Act & Assert
        do {
            _ = try await useCase.execute()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(mockRepository.getGenresCallCount, 1)
            XCTAssertEqual((error as NSError).domain, "test")
            XCTAssertEqual((error as NSError).code, 404)
        }
    }
    
    // MARK: - Integration Tests
    
    func testBothUseCases_ConcurrentExecution() async throws {
        // Arrange
        let mockRepository = MockMetaRepository()
        let authorsUseCase = GetAuthorsUseCaseImpl(repository: mockRepository)
        let genresUseCase = GetGenresUseCaseImpl(repository: mockRepository)
        
        let testAuthors = createTestAuthors()
        let testGenres = createTestGenres()
        
        mockRepository.mockAuthors = testAuthors
        mockRepository.mockGenres = testGenres
        
        // Act - Execute both use cases concurrently
        async let authorsResult = authorsUseCase.execute()
        async let genresResult = genresUseCase.execute()
        
        let authors = try await authorsResult
        let genres = try await genresResult
        
        // Assert
        XCTAssertEqual(mockRepository.getAuthorsCallCount, 1)
        XCTAssertEqual(mockRepository.getGenresCallCount, 1)
        XCTAssertEqual(authors.count, 3)
        XCTAssertEqual(genres.count, 4)
    }
    
    // MARK: - Edge Cases
    
    func testGetAuthorsUseCase_AuthorWithoutImage() async throws {
        // Arrange
        let mockRepository = MockMetaRepository()
        let useCase = GetAuthorsUseCaseImpl(repository: mockRepository)
        
        let authorWithoutImage = Author(id: 1, image: "", name: "Автор без картинки")
        mockRepository.mockAuthors = [authorWithoutImage]
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].image, "")
        XCTAssertEqual(result[0].name, "Автор без картинки")
    }
    
    func testGetAuthorsUseCase_AuthorWithEmptyName() async throws {
        // Arrange
        let mockRepository = MockMetaRepository()
        let useCase = GetAuthorsUseCaseImpl(repository: mockRepository)
        
        let authorWithEmptyName = Author(id: 1, image: "author.jpg", name: "")
        mockRepository.mockAuthors = [authorWithEmptyName]
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].name, "")
    }
    
    func testGetGenresUseCase_GenreWithEmptyName() async throws {
        // Arrange
        let mockRepository = MockMetaRepository()
        let useCase = GetGenresUseCaseImpl(repository: mockRepository)
        
        let genreWithEmptyName = Genre(id: 1, name: "")
        mockRepository.mockGenres = [genreWithEmptyName]
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].name, "")
    }
    
    func testGetAuthorsUseCase_DuplicateIds() async throws {
        // Arrange
        let mockRepository = MockMetaRepository()
        let useCase = GetAuthorsUseCaseImpl(repository: mockRepository)
        
        let duplicateAuthors = [
            Author(id: 1, image: "author1.jpg", name: "Автор Первый"),
            Author(id: 1, image: "author2.jpg", name: "Автор Второй") // Same ID
        ]
        mockRepository.mockAuthors = duplicateAuthors
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(result.count, 2) // Should return both even with duplicate IDs
        XCTAssertEqual(result[0].id, 1)
        XCTAssertEqual(result[1].id, 1)
        XCTAssertNotEqual(result[0].name, result[1].name)
    }
} 
