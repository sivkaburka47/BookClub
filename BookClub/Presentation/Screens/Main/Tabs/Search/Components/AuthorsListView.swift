//
//  AuthorsListView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct AuthorsListView: View {
    let authors: [Author]
    var onAuthorSelected: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Авторы")
                .h2TextStyle()
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(authors, id: \.name) { author in
                    AuthorRowView(author: author)
                    .onTapGesture {
                        onAuthorSelected(author.name)
                    }
                    
                }
            }
        }
    }
}
