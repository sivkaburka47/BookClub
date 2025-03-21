//
//  BookInfo.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct BookInfo: View {
    let book: BookDetails
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                Text(book.title)
                    .h2TextStyle()
                SecondaryBoldText(text: book.currentChapter, lineHeight: 1.5, size: 14)
            }
            
            ProgressView(value: book.progress)
                .progressViewStyle(LinearProgressViewStyle())
                .tint(Color("AccentDark"))
                .background(Color("AccentMedium"))
                .cornerRadius(4)
        }
    }
}
