//
//  CustomTextField.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct CustomTextField: View {
    let title: String
    @Binding var text: String
    let icon: String?
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text(title)
                    .foregroundColor(Color("AccentMedium"))
                    .bodySmallTextStyle()
                Spacer()
                TextField("", text: $text)
                    .foregroundColor(Color("AccentLight"))
                    .bodySmallTextStyle()
                    .frame(width: geometry.size.width * 0.5 + (!text.isEmpty ? 0 : 24))
                if let icon = icon, !text.isEmpty {
                    Button(action: { text = "" }) {
                        Image(icon)
                    }
                }
            }
            .frame(height: 24)
            .padding(.horizontal, 16)
            .padding(.vertical, 11)
        }
    }
}
