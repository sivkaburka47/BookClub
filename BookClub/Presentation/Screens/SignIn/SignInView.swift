//
//  SignInView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 15.03.2025.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                BookCarouselView()
                Spacer()
                SignInHeaderView()
                Spacer()
                SignInFormView(email: $email, password: $password, isPasswordVisible: $isPasswordVisible)
                Spacer()
                SignInButton()
                Spacer()
            }
        }
        .background(Color("AccentDark"))
    }
}

#Preview {
    SignInView()
}
