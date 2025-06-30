//
//  AddToFavoritesRequestDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation

struct AddToFavoritesRequestDTO: Encodable {
    let data: BookDataDTO

    struct BookDataDTO: Encodable {
        let bookId: Int
    }
}
