//
//  RegisterRequestDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation

struct RegisterRequestDTO: Codable {
    let username: String
    let email: String
    let password: String
}
