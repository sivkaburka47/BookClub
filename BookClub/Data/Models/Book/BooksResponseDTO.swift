//
//  BooksResponseDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation

struct BooksResponseDTO: Codable {
    let data: [BookDTO]
    let meta: MetaDTO
}

struct BookDTO: Codable {
    let id: Int
    let documentId: String
    let title: String
    let coverURL: String
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    let isNew: Bool
    let illustrationURL: String?
}
