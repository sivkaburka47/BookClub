//
//  QuoteRepositoryImpl.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

import Foundation

protocol QuoteRepositoryImpl {
    func getQuotes() async throws -> ProgressReponseDTO
    func createQuote() async throws -> GenresResponseDTO
    func updateProgress(documentId: String) async throws
}
