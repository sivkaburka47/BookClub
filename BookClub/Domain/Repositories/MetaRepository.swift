//
//  MetaRepository.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

import Foundation

protocol MetaRepository {
    func getAuthors() async throws -> [Author]
    func getGenres() async throws -> [Genre]
}
