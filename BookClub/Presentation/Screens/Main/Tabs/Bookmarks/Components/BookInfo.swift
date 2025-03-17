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
                SectionTitle(text: book.title)
                Text(book.currentChapter)
                    .font(.custom("VelaSans-Regular", size: 14))
                    .foregroundColor(Color("AccentDark"))
                    .lineSpacing(14 * 0.5)
            }
            
            ProgressView(value: book.progress)
                .progressViewStyle(LinearProgressViewStyle())
                .tint(Color("AccentDark"))
                .background(Color("AccentMedium"))
                .cornerRadius(4)
        }
    }
}
