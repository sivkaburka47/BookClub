//
//  ErrorResponseDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 30.06.2025.
//

import Foundation

struct ErrorResponseDTO: Codable {
    let data: String?
    let error: ErrorDetailsDTO?
}

struct ErrorDetailsDTO: Codable {
    let status: Int
    let name: String
    let message: String
    let details: ErrorDetailsContentDTO
}

struct ErrorDetailsContentDTO: Codable {
    let errors: [ValidationErrorDTO]
}

struct ValidationErrorDTO: Codable {
    let path: [String]
    let message: String
    let name: String
    let value: String
}
