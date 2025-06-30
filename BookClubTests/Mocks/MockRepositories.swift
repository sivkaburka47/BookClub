//
//  MockRepositories.swift
//  BookClubTests
//
//  Created by Test on 22.06.2025.
//

import Foundation
@testable import BookClub

// MARK: - AuthRepository Mock
class MockAuthRepository: AuthRepository {
    var shouldThrowError = false
    var errorToThrow: Error = AuthError.unknown(NSError(domain: "test", code: 0))
    var registerCallCount = 0
    var loginCallCount = 0
    var lastCredentials: Credentials?
    
    func register(credentials: Credentials) async throws {
        registerCallCount += 1
        lastCredentials = credentials
        if shouldThrowError {
            throw errorToThrow
        }
    }
    
    func login(credentials: Credentials) async throws {
        loginCallCount += 1
        lastCredentials = credentials
        if shouldThrowError {
            throw errorToThrow
        }
    }
}

// MARK: - BookRepository Mock
class MockBookRepository: BookRepository {
    var shouldThrowError = false
    var errorToThrow: Error = NSError(domain: "test", code: 0)
    var mockBooks: [Book] = []
    var mockBook: Book?
    var mockChapters: [Chapter] = []
    var mockReadingStatus: ReadingStatus?
    
    var getBooksCallCount = 0
    var getBookByIdCallCount = 0
    var findBooksByNameCallCount = 0
    var getBooksByGenreCallCount = 0
    var getBooksByAuthorCallCount = 0
    var getNewBooksCallCount = 0
    var getBookChaptersCallCount = 0
    var getChapterWithBookCallCount = 0
    
    func getBooks(page: Int?, pageSize: Int?) async throws -> [Book] {
        getBooksCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
        return mockBooks
    }
    
    func getBookById(bookId: Int) async throws -> Book {
        getBookByIdCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
        return mockBook ?? Book()
    }
    
    func findBooksByName(name: String) async throws -> [Book] {
        findBooksByNameCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
        return mockBooks
    }
    
    func getBooksByGenre(genre: Int) async throws -> [Book] {
        getBooksByGenreCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
        return mockBooks
    }
    
    func getBooksByAuthor(author: Int) async throws -> [Book] {
        getBooksByAuthorCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
        return mockBooks
    }
    
    func getNewBooks() async throws -> [Book] {
        getNewBooksCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
        return mockBooks
    }
    
    func getBookChapters(bookId: Int) async throws -> [Chapter] {
        getBookChaptersCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
        return mockChapters
    }
    
    func getChapterWithBook(chapterId: Int) async throws -> ReadingStatus? {
        getChapterWithBookCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
        return mockReadingStatus
    }
}

// MARK: - FavoritesRepository Mock
class MockFavoritesRepository: FavoritesRepository {
    var shouldThrowError = false
    var errorToThrow: Error = NSError(domain: "test", code: 0)
    var mockFavoriteIds: [Int] = []
    var mockFavoriteDocumentIds: [String] = []
    
    var getFavoritesCallCount = 0
    var addToFavoritesCallCount = 0
    var removeFromFavoritesCallCount = 0
    var getFavoritesByBookIdCallCount = 0
    
    func getFavorites() async throws -> [Int] {
        getFavoritesCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
        return mockFavoriteIds
    }
    
    func addToFavorites(bookId: Int) async throws {
        addToFavoritesCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
        mockFavoriteIds.append(bookId)
    }
    
    func removeFromFavorites(documentId: String) async throws {
        removeFromFavoritesCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
    }
    
    func getFavoritesByBookId(bookId: Int) async throws -> [String] {
        getFavoritesByBookIdCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
        return mockFavoriteDocumentIds
    }
}

// MARK: - MetaRepository Mock
class MockMetaRepository: MetaRepository {
    var shouldThrowError = false
    var errorToThrow: Error = NSError(domain: "test", code: 0)
    var mockAuthors: [Author] = []
    var mockGenres: [Genre] = []
    
    var getAuthorsCallCount = 0
    var getGenresCallCount = 0
    
    func getAuthors() async throws -> [Author] {
        getAuthorsCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
        return mockAuthors
    }
    
    func getGenres() async throws -> [Genre] {
        getGenresCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
        return mockGenres
    }
}

// MARK: - ProgressRepository Mock
class MockProgressRepository: ProgressRepository {
    var shouldThrowError = false
    var errorToThrow: Error = NSError(domain: "test", code: 0)
    var mockProgress: [BookClub.Progress] = []

    var getProgressCallCount = 0
    var saveProgressCallCount = 0
    var updateProgressCallCount = 0
    var lastSavedProgress: BookClub.Progress?
    var lastUpdatedProgress: BookClub.Progress?
    var lastDocumentId: String?
    
    func getProgress() async throws -> [BookClub.Progress] {
        getProgressCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
        return mockProgress
    }
    
    func saveProgress(progress: BookClub.Progress) async throws {
        saveProgressCallCount += 1
        lastSavedProgress = progress
        if shouldThrowError {
            throw errorToThrow
        }
    }
    
    func updateProgress(documentId: String, progress: BookClub.Progress) async throws {
        updateProgressCallCount += 1
        lastDocumentId = documentId
        lastUpdatedProgress = progress
        if shouldThrowError {
            throw errorToThrow
        }
    }
}

// MARK: - QuoteRepository Mock
class MockQuoteRepository: QuoteRepository {
    var shouldThrowError = false
    var errorToThrow: Error = NSError(domain: "test", code: 0)
    var mockQuotes: [Quote] = []
    
    var getQuotesCallCount = 0
    var createQuoteCallCount = 0
    var lastCreatedQuote: Quote?
    
    func getQuotes() async throws -> [Quote] {
        getQuotesCallCount += 1
        if shouldThrowError {
            throw errorToThrow
        }
        return mockQuotes
    }
    
    func createQuote(quote: Quote) async throws {
        createQuoteCallCount += 1
        lastCreatedQuote = quote
        if shouldThrowError {
            throw errorToThrow
        }
    }
}
