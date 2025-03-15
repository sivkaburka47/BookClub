//
//  CustomButtonStyle.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 15.03.2025.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color("AccentDark") : Color("AccentLight"))
            .font(.custom("VelaSans-Bold", size: 16))
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                configuration.isPressed ? Color.white : Color("AccentMedium")
            )
            .cornerRadius(12)
            .lineSpacing(16 * 1.3 - 16)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
