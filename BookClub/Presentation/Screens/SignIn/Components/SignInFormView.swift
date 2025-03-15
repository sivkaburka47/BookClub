//
//  SignInFormView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct SignInFormView: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var isPasswordVisible: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            CustomTextField(title: "Почта", text: $email, icon: "Close")
            Divider().background(Color("AccentMedium")).padding(.leading, 16)
            CustomSecureField(title: "Пароль", text: $password, isPasswordVisible: $isPasswordVisible)
        }
        .frame(height: 92)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color("AccentMedium"), lineWidth: 1))
        .padding(.horizontal, 16)
    }
}
