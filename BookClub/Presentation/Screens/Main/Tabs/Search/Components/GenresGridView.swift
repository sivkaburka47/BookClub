//
//  GenresGridView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct GenresGridView: View {
    let genres: [String]
    
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionTitle(text: "Жанры")
            
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(genres, id: \.self) { genre in
                    SecondaryText(text: genre, lineHeight: 1.142, size: 14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(16)
                        .background(Color("AccentLight"))
                        .cornerRadius(8)
                }
            }
        }
    }
}

