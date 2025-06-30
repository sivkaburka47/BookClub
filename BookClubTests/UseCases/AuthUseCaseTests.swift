//
//  AuthUseCaseTests.swift
//  BookClubTests
//
//  Created by Test on 22.06.2025.
//

import XCTest
@testable import BookClub

final class AuthUseCaseTests: XCTestCase {
    
    // MARK: - LoginUseCase Tests
    
    func testLoginUseCase_Success() async throws {
        // Arrange
        let mockRepository = MockAuthRepository()
        let useCase = LoginUseCaseImpl(repository: mockRepository)
        let credentials = Credentials(email: "test@example.com", password: "password123")
        
        // Act
        try await useCase.execute(request: credentials)
        
        // Assert
        XCTAssertEqual(mockRepository.loginCallCount, 1)
        XCTAssertEqual(mockRepository.lastCredentials?.email, "test@example.com")
        XCTAssertEqual(mockRepository.lastCredentials?.password, "password123")
    }
    
    func testLoginUseCase_AuthErrorHandling() async throws {
        // Arrange
        let mockRepository = MockAuthRepository()
        let useCase = LoginUseCaseImpl(repository: mockRepository)
        let credentials = Credentials(email: "test@example.com", password: "wrong")
        let authError = AuthError.invalidCredentials("Invalid credentials")
        
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = authError
        
        // Act & Assert
        do {
            try await useCase.execute(request: credentials)
            XCTFail("Expected AuthError to be thrown")
        } catch let error as AuthError {
            XCTAssertEqual(mockRepository.loginCallCount, 1)
            switch error {
            case .invalidCredentials(let message):
                XCTAssertEqual(message, "Invalid credentials")
            default:
                XCTFail("Expected invalidCredentials error")
            }
        }
    }
    
    func testLoginUseCase_UnknownErrorHandling() async throws {
        // Arrange
        let mockRepository = MockAuthRepository()
        let useCase = LoginUseCaseImpl(repository: mockRepository)
        let credentials = Credentials(email: "test@example.com", password: "password")
        let unknownError = NSError(domain: "test", code: 500, userInfo: [NSLocalizedDescriptionKey: "Server error"])
        
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = unknownError
        
        // Act & Assert
        do {
            try await useCase.execute(request: credentials)
            XCTFail("Expected AuthError.unknown to be thrown")
        } catch let error as AuthError {
            switch error {
            case .unknown(let innerError):
                XCTAssertEqual((innerError as NSError).domain, "test")
                XCTAssertEqual((innerError as NSError).code, 500)
            default:
                XCTFail("Expected unknown error")
            }
        }
    }
    
    // MARK: - RegisterUseCase Tests
    
    func testRegisterUseCase_Success() async throws {
        // Arrange
        let mockRepository = MockAuthRepository()
        let useCase = RegisterUseCaseImpl(repository: mockRepository)
        let credentials = Credentials(email: "newuser@example.com", password: "password123")
        
        // Act
        try await useCase.execute(request: credentials)
        
        // Assert
        XCTAssertEqual(mockRepository.registerCallCount, 1)
        XCTAssertEqual(mockRepository.lastCredentials?.email, "newuser@example.com")
        XCTAssertEqual(mockRepository.lastCredentials?.password, "password123")
    }
    
    func testRegisterUseCase_AuthErrorHandling() async throws {
        // Arrange
        let mockRepository = MockAuthRepository()
        let useCase = RegisterUseCaseImpl(repository: mockRepository)
        let credentials = Credentials(email: "existing@example.com", password: "password")
        let authError = AuthError.serverError(status: 409, message: "User already exists")
        
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = authError
        
        // Act & Assert
        do {
            try await useCase.execute(request: credentials)
            XCTFail("Expected AuthError to be thrown")
        } catch let error as AuthError {
            XCTAssertEqual(mockRepository.registerCallCount, 1)
            switch error {
            case .serverError(let status, let message):
                XCTAssertEqual(status, 409)
                XCTAssertEqual(message, "User already exists")
            default:
                XCTFail("Expected serverError")
            }
        }
    }
    
    // MARK: - Edge Cases Tests
    
    func testLoginUseCase_EmptyCredentials() async throws {
        // Arrange
        let mockRepository = MockAuthRepository()
        let useCase = LoginUseCaseImpl(repository: mockRepository)
        let credentials = Credentials(email: "", password: "")
        
        // Act
        try await useCase.execute(request: credentials)
        
        // Assert
        XCTAssertEqual(mockRepository.loginCallCount, 1)
        XCTAssertEqual(mockRepository.lastCredentials?.email, "")
        XCTAssertEqual(mockRepository.lastCredentials?.password, "")
    }
    
    func testRegisterUseCase_EmptyCredentials() async throws {
        // Arrange
        let mockRepository = MockAuthRepository()
        let useCase = RegisterUseCaseImpl(repository: mockRepository)
        let credentials = Credentials(email: "", password: "")
        
        // Act
        try await useCase.execute(request: credentials)
        
        // Assert
        XCTAssertEqual(mockRepository.registerCallCount, 1)
        XCTAssertEqual(mockRepository.lastCredentials?.email, "")
        XCTAssertEqual(mockRepository.lastCredentials?.password, "")
    }
} 
