//
//  SignInButton.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct SignInButton: View {
    @Binding var isSignedIn: Bool
    var isFormValid: Bool
    
    var body: some View {
        HStack{
            Button(action: {
                isSignedIn = true
            }) {
                Text("Войти")
                    .font(.custom("VelaSans-Bold", size: 16))
                    .foregroundColor(isFormValid ? Color("AccentDark") : Color("AccentLight"))
            }
            .disabled(!isFormValid)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .center)
            .background(isFormValid ? Color("White") : Color("AccentMedium"))
            .cornerRadius(12)
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
    }
    
}
