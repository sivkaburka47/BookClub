//
//  UserDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation

struct UserDTO: Codable {
    let id: Int
    let documentId: String
    let username: String
    let email: String
    let provider: String
    let confirmed: Bool
    let blocked: Bool
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
}
