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

            VStack(alignment: .leading) {
                SectionTitle(text: book.title)
                Text(book.author)
                    .font(.custom("VelaSans-Regular", size: 14))
                    .foregroundColor(Color("AccentDark"))
                    .lineSpacing(14 * 0.5)
            }
        }
    }
}
