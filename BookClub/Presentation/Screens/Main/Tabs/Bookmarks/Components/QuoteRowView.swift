//
//  QuoteRowView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct QuoteRowView: View {
    let quote: Quote

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(quote.text)
                .font(.custom("georgiai", size: 16))
                .foregroundColor(Color("Black"))
                .lineSpacing(16 * 0.5)

            Text("\(quote.bookTitle) • \(quote.author)")
                .font(.custom("VelaSans-Regular", size: 12))
                .foregroundColor(Color("AccentDark"))
                .lineSpacing(12 * 0.5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color("AccentLight"))
        .cornerRadius(8)
    }
}
