//
//  AuthorRowView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct AuthorRowView: View {
    let author: Author
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(author.image)
                .resizable()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            Text(author.name)
                .bodyTextStyle()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color("AccentLight"))
        .cornerRadius(8)
    }
}

