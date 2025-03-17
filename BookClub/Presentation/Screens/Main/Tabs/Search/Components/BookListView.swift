//
//  BookListView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct BookListView: View {
    let books: [BookCard]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(books) { book in
                BookRowView(book: book)
            }
        }
    }
}
