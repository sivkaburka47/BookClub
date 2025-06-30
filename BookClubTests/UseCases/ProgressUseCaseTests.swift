//
//  ProgressUseCaseTests.swift
//  BookClubTests
//
//  Created by Test on 22.06.2025.
//

import XCTest
@testable import BookClub

final class ProgressUseCaseTests: XCTestCase {
    
    // MARK: - Test Data
    
    private func createTestProgress(id: Int = 1, value: Int = 50, chapterId: Int = 1, updatedAt: Date = Date()) -> BookClub.Progress {
        return BookClub.Progress(
            id: id,
            updatedAt: updatedAt,
            documentId: "doc_\(id)",
            value: value,
            chapterId: chapterId
        )
    }
    
    private func createTestReadingStatus(id: Int = 1, value: Double = 50.0) -> ReadingStatus {
        return ReadingStatus(
            id: id,
            bookId: 1,
            bookTitle: "Test Book",
            bookImageUrl: "https://example.com/cover.jpg",
            chapterTitle: "Test Chapter",
            value: value
        )
    }
    
    // MARK: - GetProgressUseCase Tests
    
    func testGetProgressUseCase_Success() async throws {
        // Arrange
        let mockProgressRepository = MockProgressRepository()
        let mockBookRepository = MockBookRepository()
        let useCase = GetProgressUseCaseImpl(
            repository: mockProgressRepository,
            bookRepository: mockBookRepository
        )
        
        let testProgress = [createTestProgress(value: 75, chapterId: 1)]
        let testReadingStatus = createTestReadingStatus(value: 0.0)
        
        mockProgressRepository.mockProgress = testProgress
        mockBookRepository.mockReadingStatus = testReadingStatus
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(mockProgressRepository.getProgressCallCount, 1)
        XCTAssertEqual(mockBookRepository.getChapterWithBookCallCount, 1)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.value, 75.0)
    }
    
    func testGetProgressUseCase_NoProgress() async throws {
        // Arrange
        let mockProgressRepository = MockProgressRepository()
        let mockBookRepository = MockBookRepository()
        let useCase = GetProgressUseCaseImpl(
            repository: mockProgressRepository,
            bookRepository: mockBookRepository
        )
        
        mockProgressRepository.mockProgress = []
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(mockProgressRepository.getProgressCallCount, 1)
        XCTAssertEqual(mockBookRepository.getChapterWithBookCallCount, 0)
        XCTAssertNil(result)
    }
    
    func testGetProgressUseCase_NoReadingStatusFound() async throws {
        // Arrange
        let mockProgressRepository = MockProgressRepository()
        let mockBookRepository = MockBookRepository()
        let useCase = GetProgressUseCaseImpl(
            repository: mockProgressRepository,
            bookRepository: mockBookRepository
        )
        
        let testProgress = [createTestProgress(value: 50, chapterId: 1)]
        mockProgressRepository.mockProgress = testProgress
        mockBookRepository.mockReadingStatus = nil
        
        // Act
        let result = try await useCase.execute()
        
        // Assert
        XCTAssertEqual(mockProgressRepository.getProgressCallCount, 1)
        XCTAssertEqual(mockBookRepository.getChapterWithBookCallCount, 1)
        XCTAssertNil(result)
    }
    
    func testGetProgressUseCase_GetLastReadChapterLogic() async throws {
        // Arrange
        let useCase = GetProgressUseCaseImpl(
            repository: MockProgressRepository(),
            bookRepository: MockBookRepository()
        )
        
        let now = Date()
        let olderDate = now.addingTimeInterval(-3600) // 1 hour ago
        let newerDate = now.addingTimeInterval(-1800) // 30 minutes ago
        
        let progresses = [
            createTestProgress(id: 1, value: 50, chapterId: 1, updatedAt: olderDate),
            createTestProgress(id: 2, value: 75, chapterId: 2, updatedAt: newerDate),
            createTestProgress(id: 3, value: 75, chapterId: 3, updatedAt: now), // Same value, newest
            createTestProgress(id: 4, value: 0, chapterId: 4, updatedAt: now) // Should be filtered out
        ]
        
        // Act
        let result = useCase.getLastReadChapter(from: progresses)
        
        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.id, 3) // Should return the one with highest value and newest date
        XCTAssertEqual(result?.value, 75)
        XCTAssertEqual(result?.chapterId, 3)
    }
    
    func testGetProgressUseCase_GetLastReadChapterWithZeroProgress() async throws {
        // Arrange
        let useCase = GetProgressUseCaseImpl(
            repository: MockProgressRepository(),
            bookRepository: MockBookRepository()
        )
        
        let progresses = [
            createTestProgress(id: 1, value: 0, chapterId: 1),
            createTestProgress(id: 2, value: 0, chapterId: 2)
        ]
        
        // Act
        let result = useCase.getLastReadChapter(from: progresses)
        
        // Assert
        XCTAssertNil(result) // Should return nil as all progress values are 0
    }
    
    func testGetProgressUseCase_Error() async throws {
        // Arrange
        let mockProgressRepository = MockProgressRepository()
        let mockBookRepository = MockBookRepository()
        let useCase = GetProgressUseCaseImpl(
            repository: mockProgressRepository,
            bookRepository: mockBookRepository
        )
        
        mockProgressRepository.shouldThrowError = true
        mockProgressRepository.errorToThrow = NSError(domain: "test", code: 500)
        
        // Act & Assert
        do {
            _ = try await useCase.execute()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(mockProgressRepository.getProgressCallCount, 1)
        }
    }
    
    // MARK: - SaveProgressUseCase Tests
    
    func testSaveProgressUseCase_Success() async throws {
        // Arrange
        let mockRepository = MockProgressRepository()
        let useCase = SaveProgressUseCaseImpl(repository: mockRepository)
        let testProgress = createTestProgress()
        
        // Act
        try await useCase.execute(progress: testProgress)
        
        // Assert
        XCTAssertEqual(mockRepository.saveProgressCallCount, 1)
        XCTAssertEqual(mockRepository.lastSavedProgress?.id, testProgress.id)
        XCTAssertEqual(mockRepository.lastSavedProgress?.value, testProgress.value)
        XCTAssertEqual(mockRepository.lastSavedProgress?.chapterId, testProgress.chapterId)
    }
    
    func testSaveProgressUseCase_Error() async throws {
        // Arrange
        let mockRepository = MockProgressRepository()
        let useCase = SaveProgressUseCaseImpl(repository: mockRepository)
        let testProgress = createTestProgress()
        
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = NSError(domain: "test", code: 500)
        
        // Act & Assert
        do {
            try await useCase.execute(progress: testProgress)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(mockRepository.saveProgressCallCount, 1)
        }
    }
    
    // MARK: - UpdateProgressUseCase Tests

    func testUpdateProgressUseCase_Error() async throws {
        // Arrange
        let mockRepository = MockProgressRepository()
        let useCase = UpdateProgressUseCaseImpl(repository: mockRepository)
        let testProgress = createTestProgress()
        
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = NSError(domain: "test", code: 404)
        
        // Act & Assert
        do {
            try await useCase.execute(progress: testProgress)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(mockRepository.updateProgressCallCount, 1)
        }
    }
    
    // MARK: - Edge Cases
    
    func testSaveProgressUseCase_ZeroProgress() async throws {
        // Arrange
        let mockRepository = MockProgressRepository()
        let useCase = SaveProgressUseCaseImpl(repository: mockRepository)
        let zeroProgress = createTestProgress(value: 0)
        
        // Act
        try await useCase.execute(progress: zeroProgress)
        
        // Assert
        XCTAssertEqual(mockRepository.saveProgressCallCount, 1)
        XCTAssertEqual(mockRepository.lastSavedProgress?.value, 0)
    }
    
} 
