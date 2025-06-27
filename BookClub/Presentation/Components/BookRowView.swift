//
//  BookRowView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct BookRowView: View {
    let book: BookGridCard

    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: book.image)) { image in
                image
                    .resizable()
                    .frame(width: 80, height: 126)
                    .cornerRadius(4)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 80, height: 126)
                    .cornerRadius(4)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .h2TextStyle()
                
                Text(book.authors.map { $0.name }.joined(separator: ", "))
                    .bodySmallTextStyle()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
