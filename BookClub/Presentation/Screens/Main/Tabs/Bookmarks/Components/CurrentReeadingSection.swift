//
//  CurrentReeadingSection.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct CurrentReadingSection: View {
    let book: BookDetails
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                SectionTitle(text: "Читаете сейчас")
                Spacer()
                PlayButton()
            }
            
            HStack(spacing: 16) {
                BookCover(image: book.image)
                BookInfo(book: book)
            }
        }
    }
}
