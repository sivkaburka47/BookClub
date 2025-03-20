//
//  GenresGridView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct GenresGridView: View {
    let genres: [String]
    var onGenreSelected: (String) -> Void
    @State private var rowHeights: [Int: CGFloat] = [:]
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionTitle(text: "Жанры")
            
            LazyVGrid(columns: columns, spacing: 8) {
                let indexedGenres = Array(genres.enumerated())
                
                ForEach(indexedGenres, id: \.element) { item in
                    let index = item.offset
                    let genre = item.element
                    let rowIndex = index / columns.count
                    
                    SecondaryText(text: genre, lineHeight: 1.142, size: 14)
                        .padding(16)
                        .background(GeometryReader { proxy in
                            Color.clear
                                .preference(
                                    key: RowHeightPreferenceKey.self,
                                    value: [rowIndex: proxy.size.height]
                                )
                        })
                        .frame(height: rowHeights[rowIndex])
                        .background(Color("AccentLight"))
                        .cornerRadius(8)
                        .onTapGesture {
                            onGenreSelected(genre)
                        }
                }
            }
            .onPreferenceChange(RowHeightPreferenceKey.self) { newHeights in
                rowHeights.merge(newHeights) { _, new in new }
            }
        }
    }
}

