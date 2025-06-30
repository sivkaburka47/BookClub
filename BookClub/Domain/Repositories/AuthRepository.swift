//
//  AuthRepository.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

import Foundation

protocol AuthRepository {
    func register(credentials: Credentials) async throws
    func login(credentials: Credentials) async throws
}
