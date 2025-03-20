//
//  BookRowView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct BookRowView: View {
    let book: BookCard

    var body: some View {
        HStack(spacing: 16) {
            Image(book.image)
                .resizable()
                .frame(width: 80, height: 126)
                .cornerRadius(4)

            VStack(alignment: .leading, spacing: 0) {
                SectionTitle(text: book.title)
                SecondaryText(text: book.authors.joined(separator: ", "), lineHeight: 1.5, size: 14)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
