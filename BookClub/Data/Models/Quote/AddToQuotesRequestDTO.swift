//
//  AddToQuotesRequestDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation

struct AddToQuotesRequestDTO: Encodable {
    let data: QuoteDataDTO

    struct QuoteDataDTO: Encodable {
        let text: String
        let bookId: Int
    }
}
