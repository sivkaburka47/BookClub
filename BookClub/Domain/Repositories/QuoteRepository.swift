//
//  QuoteRepository.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

import Foundation

protocol QuoteRepository {
    func getQuotes() async throws -> [Quote]
    func createQuote(quote: Quote) async throws
}
