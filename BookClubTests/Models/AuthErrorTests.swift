//
//  AuthErrorTests.swift
//  BookClubTests
//
//  Created by Станислав Дейнекин on 30.06.2025.
//

import XCTest
@testable import BookClub

final class AuthErrorTests: XCTestCase {
    
    // MARK: - AuthError Tests
    
    func testAuthError_InvalidCredentials() {
        // Arrange & Act
        let error = AuthError.invalidCredentials("Неверный email или пароль")
        
        // Assert
        XCTAssertEqual(error.errorDescription, "Неверный email или пароль")
        
        // Test pattern matching
        switch error {
        case .invalidCredentials(let message):
            XCTAssertEqual(message, "Неверный email или пароль")
        default:
            XCTFail("Expected invalidCredentials case")
        }
    }
    
    func testAuthError_NetworkError() {
        // Arrange
        let networkError = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: [NSLocalizedDescriptionKey: "No internet connection"])
        
        // Act
        let error = AuthError.networkError(networkError)
        
        // Assert
        XCTAssertEqual(error.errorDescription, "Network error: No internet connection")
        
        // Test pattern matching
        switch error {
        case .networkError(let innerError):
            XCTAssertEqual((innerError as NSError).domain, NSURLErrorDomain)
            XCTAssertEqual((innerError as NSError).code, NSURLErrorNotConnectedToInternet)
        default:
            XCTFail("Expected networkError case")
        }
    }
    
    func testAuthError_ServerError() {
        // Arrange & Act
        let error = AuthError.serverError(status: 401, message: "Unauthorized")
        
        // Assert
        XCTAssertEqual(error.errorDescription, "Unauthorized")
        
        // Test pattern matching
        switch error {
        case .serverError(let status, let message):
            XCTAssertEqual(status, 401)
            XCTAssertEqual(message, "Unauthorized")
        default:
            XCTFail("Expected serverError case")
        }
    }
    
    func testAuthError_UnknownError() {
        // Arrange
        let unknownError = NSError(domain: "test", code: 500, userInfo: [NSLocalizedDescriptionKey: "Internal server error"])
        
        // Act
        let error = AuthError.unknown(unknownError)
        
        // Assert
        XCTAssertEqual(error.errorDescription, "Unknown error: Internal server error")
        
        // Test pattern matching
        switch error {
        case .unknown(let innerError):
            XCTAssertEqual((innerError as NSError).domain, "test")
            XCTAssertEqual((innerError as NSError).code, 500)
        default:
            XCTFail("Expected unknown case")
        }
    }
    
    // MARK: - Edge Cases
    
    func testAuthError_EmptyMessages() {
        // Arrange & Act
        let invalidCredentialsError = AuthError.invalidCredentials("")
        let serverError = AuthError.serverError(status: 500, message: "")
        
        // Assert
        XCTAssertEqual(invalidCredentialsError.errorDescription, "")
        XCTAssertEqual(serverError.errorDescription, "")
    }
    
    func testAuthError_NetworkErrorWithoutLocalizedDescription() {
        // Arrange
        let networkError = NSError(domain: "test", code: 404)
        
        // Act
        let error = AuthError.networkError(networkError)
        
        // Assert
        XCTAssertNotNil(error.errorDescription)
        XCTAssertTrue(error.errorDescription?.contains("Network error:") == true)
    }
    
    func testAuthError_UnknownErrorWithoutLocalizedDescription() {
        // Arrange
        let unknownError = NSError(domain: "test", code: 500)
        
        // Act
        let error = AuthError.unknown(unknownError)
        
        // Assert
        XCTAssertNotNil(error.errorDescription)
        XCTAssertTrue(error.errorDescription?.contains("Unknown error:") == true)
    }
    
    func testAuthError_LocalizedErrorConformance() {
        // Arrange
        let errors: [AuthError] = [
            .invalidCredentials("Invalid"),
            .networkError(NSError(domain: "test", code: 0)),
            .serverError(status: 400, message: "Bad Request"),
            .unknown(NSError(domain: "test", code: 0))
        ]
        
        // Act & Assert
        for error in errors {
            XCTAssertNotNil(error.errorDescription, "All AuthError cases should have error descriptions")
            
            // Test that it can be cast to LocalizedError
            let localizedError = error as LocalizedError
            XCTAssertNotNil(localizedError.errorDescription)
        }
    }
    
    // MARK: - Common HTTP Status Codes
    
    func testAuthError_CommonHTTPStatusCodes() {
        // Arrange & Act
        let badRequest = AuthError.serverError(status: 400, message: "Bad Request")
        let unauthorized = AuthError.serverError(status: 401, message: "Unauthorized")
        let forbidden = AuthError.serverError(status: 403, message: "Forbidden")
        let notFound = AuthError.serverError(status: 404, message: "Not Found")
        let internalServerError = AuthError.serverError(status: 500, message: "Internal Server Error")
        
        // Assert
        switch badRequest {
        case .serverError(let status, _):
            XCTAssertEqual(status, 400)
        default:
            XCTFail("Expected serverError case")
        }
        
        switch unauthorized {
        case .serverError(let status, _):
            XCTAssertEqual(status, 401)
        default:
            XCTFail("Expected serverError case")
        }
        
        switch forbidden {
        case .serverError(let status, _):
            XCTAssertEqual(status, 403)
        default:
            XCTFail("Expected serverError case")
        }
        
        switch notFound {
        case .serverError(let status, _):
            XCTAssertEqual(status, 404)
        default:
            XCTFail("Expected serverError case")
        }
        
        switch internalServerError {
        case .serverError(let status, _):
            XCTAssertEqual(status, 500)
        default:
            XCTFail("Expected serverError case")
        }
    }
} 
