//
//  StyledButtonContent.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.03.2025.
//

import SwiftUI

struct StyledButtonContent: View {
    let text: String
    let icon: String
    let style: ButtonStyle
    
    enum ButtonStyle {
        case dark
        case light
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            CustomIcon(name: icon, size: 18, color: iconColor)
            Text(text)
                .font(.custom("VelaSans-Bold", size: 17))
                .foregroundColor(textColor)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(backgroundColor)
        .cornerRadius(12)
    }
    
    private var backgroundColor: Color {
        switch style {
        case .dark:
            return Color("AccentDark")
        case .light:
            return Color("AccentLight")
        }
    }
    
    private var textColor: Color {
        switch style {
        case .dark:
            return Color("White")
        case .light:
            return Color("AccentDark")
        }
    }
    
    private var iconColor: Color {
        switch style {
        case .dark:
            return Color("White")
        case .light:
            return Color("AccentDark")
        }
    }
}
