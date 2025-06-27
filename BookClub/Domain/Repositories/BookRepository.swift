//
//  BookRepository.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

import Foundation

protocol BookRepository {
    func getBooks(page: Int?, pageSize: Int?) async throws -> [Book]
    func getBookById(bookId: Int) async throws -> Book
    func findBooksByName(name: String) async throws -> [Book]
    func getBooksByGenre(genre: Int) async throws -> [Book]
    func getBooksByAuthor(author: Int) async throws -> [Book]
    func getNewBooks() async throws -> [Book]
    func getBookChapters(bookId: Int) async throws -> [Chapter]
    func getChapterWithBook(chapterId: Int) async throws -> ReadingStatus?
}
