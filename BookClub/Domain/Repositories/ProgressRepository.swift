//
//  ProgressRepository.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

import Foundation

protocol ProgressRepository {
    func getProgress() async throws -> [Progress]
    func saveProgress(progress: Progress) async throws
    func updateProgress(documentId: String, progress: Progress) async throws
}
