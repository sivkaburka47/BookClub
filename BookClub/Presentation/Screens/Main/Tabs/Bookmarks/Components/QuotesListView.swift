//
//  QuotesListView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct QuotesListView: View {
    let quotes: [Quote]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(quotes) { quote in
                QuoteRowView(quote: quote)
            }
        }
    }
}
