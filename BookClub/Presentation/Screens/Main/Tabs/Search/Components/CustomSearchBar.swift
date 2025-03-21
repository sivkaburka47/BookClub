//
//  CustomSearchBar.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 8) {
            if text.isEmpty {
                Image("Search")
                    .renderingMode(.template)
                    .foregroundColor(Color("AccentMedium"))
                    .frame(width: 20, height: 20)
            }
            
            TextField("", text: $text, prompt: Text("Поиск по книгам")
                .foregroundColor(Color("AccentMedium")))
                .bodyTextStyle()
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image("Close")
                        .renderingMode(.template)
                        .foregroundColor(Color("AccentDark"))
                        .frame(width: 24, height: 24)
                }
            }
        }
        .padding(.vertical, 7)
        .padding(.horizontal, 16)
        .frame(height: 44)
        .background(Color("White"))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("AccentMedium"), lineWidth: 1)
        )
    }
}
