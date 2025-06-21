//
//  MetaDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

struct MetaDTO: Codable {
    let pagination: PaginationDTO
}

struct PaginationDTO: Codable {
    let page: Int
    let pageSize: Int
    let pageCount: Int
    let total: Int
}
