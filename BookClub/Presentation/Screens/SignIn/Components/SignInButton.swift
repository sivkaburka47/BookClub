//
//  SignInButton.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct SignInButton: View {
    @Binding var isSignedIn: Bool
    
    var body: some View {
        Button(action: {
            isSignedIn = true
        }) {
            Text("Войти")
        }
        .buttonStyle(CustomButtonStyle())
        .padding(.horizontal, 16)
    }
}
