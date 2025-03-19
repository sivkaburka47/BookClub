//
//  ScreenTitle.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct ScreenTitle: View {
    enum TitleStyle {
        case red
        case darkGreen
        case light
    }
    
    let text: String
    let style: TitleStyle
    
    var body: some View {
        Text(text)
            .font(.custom("AlumniSans-Bold", size: 48))
            .textCase(.uppercase)
            .foregroundColor(color(for: style))
    }
    
    private func color(for style: TitleStyle) -> Color {
        switch style {
        case .red:
            return Color("Secondary")
        case .darkGreen:
            return Color("AccentDark")
        case .light:
            return Color("AccentLight")
        }
    }
}
