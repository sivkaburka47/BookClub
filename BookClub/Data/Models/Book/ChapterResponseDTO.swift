//
//  ChapterResponseDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation

struct ChapterResponseDTO: Codable {
    let data: [ChapterDTO]
    let meta: MetaDTO
}

struct ChapterDTO: Codable, Identifiable {
    let id: Int
    let documentId: String
    let text: String
    let title: String
    let order: Int
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
}
