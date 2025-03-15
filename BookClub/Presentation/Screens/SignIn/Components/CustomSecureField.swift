//
//  CustomSecureField.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct CustomSecureField: View {
    let title: String
    @Binding var text: String
    @Binding var isPasswordVisible: Bool
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text(title)
                    .font(.custom("VelaSans-Regular", size: 14))
                    .foregroundColor(Color("AccentMedium"))
                Spacer()
                Group {
                    if isPasswordVisible {
                        TextField("", text: $text)
                    } else {
                        SecureField("", text: $text)
                    }
                }
                .font(.custom("VelaSans-Regular", size: 14))
                .foregroundColor(Color("AccentLight"))
                .frame(width: geometry.size.width * 0.5 + (!text.isEmpty ? 0 : 24))
                if !text.isEmpty {
                    Button(action: { isPasswordVisible.toggle() }) {
                        Image(isPasswordVisible ? "EyeOff" : "EyeOn")
                    }
                }
            }
            .frame(height: 24)
            .padding(.horizontal, 16)
            .padding(.vertical, 11)
        }
    }
}
