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
                CustomIcon(name: "Search", size: 20, color: Color("AccentMedium"))
            }
            
            TextField("", text: $text, prompt: Text("Поиск по книгам")
                .foregroundColor(Color("AccentMedium")))
                .bodyTextStyle()
            
            if !text.isEmpty {
                CustomIcon(name: "Close", size: 24, color: Color("AccentDark"))
                    .onTapGesture { text = "" }
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
