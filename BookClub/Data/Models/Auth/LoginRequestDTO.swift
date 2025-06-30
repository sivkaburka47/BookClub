//
//  LoginRequestDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation

struct LoginRequestDTO: Codable {
    let identifier: String
    let password: String
}
