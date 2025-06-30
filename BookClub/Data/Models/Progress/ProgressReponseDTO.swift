//
//  ProgressReponseDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation

struct ProgressReponseDTO: Codable {
    let data: [ProgressDTO]
    let meta: MetaDTO
}

struct ProgressDTO: Codable, Identifiable {
    let id: Int
    let documentId: String
    let value: Int
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    let chapterId: Int
}

extension ProgressDTO {
    func toDomain() -> Progress {
        Progress(
            id: id,
            updatedAt: ISO8601DateFormatter().date(from: updatedAt) ?? Date(),
            documentId: documentId,
            value: value,
            chapterId: chapterId
        )
    }
}
