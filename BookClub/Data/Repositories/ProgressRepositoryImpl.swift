//
//  ProgressRepositoryImpl.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

import Foundation

protocol ProgressRepositoryImpl {
    func getProgress() async throws -> ProgressReponseDTO
    func saveProgress(bookId: Int) async throws -> GenresResponseDTO
    func updateProgress(documentId: String) async throws
}
