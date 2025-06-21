//
//  AuthResponseDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation

struct AuthResponseDTO: Codable {
    let jwt: String
    let user: UserDTO
}
