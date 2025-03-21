//
//  H2TextModifier.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.03.2025.
//

import SwiftUI

struct H2TextModifier: ViewModifier {
    let size: CGFloat = 24
    let lineHeight: CGFloat = 1
    
    func body(content: Content) -> some View {
        let uiFont = UIFont(name: "AlumniSans-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
        let adjustedLineHeight = uiFont.lineHeight * lineHeight
        let lineSpacing = adjustedLineHeight - uiFont.lineHeight
        let verticalPadding = lineSpacing / 2
        
        return content
            .font(Font.custom("AlumniSans-Bold", size: size))
            .foregroundColor(Color("AccentDark"))
            .textCase(.uppercase)
            .multilineTextAlignment(.leading)
            .lineSpacing(lineSpacing)
            .padding(.vertical, verticalPadding)
    }
}

extension View {
    func h2TextStyle() -> some View {
        self.modifier(H2TextModifier())
    }
}
