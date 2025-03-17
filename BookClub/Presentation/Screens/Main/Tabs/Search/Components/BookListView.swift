//
//  BookListView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct BookListView: View {
    let books: [BookCard]
    let spacing: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(books) { book in
                BookRowView(book: book)
            }
        }
    }
}
