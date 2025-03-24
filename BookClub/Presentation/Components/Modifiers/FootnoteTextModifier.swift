//
//  FootnoteTextModifier.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.03.2025.
//

import SwiftUI

struct FootnoteTextModifier: ViewModifier {
    let size: CGFloat = 10
    let lineHeight: CGFloat = 1.3
    
    func body(content: Content) -> some View {
        let uiFont = UIFont(name: "VelaSans-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        let adjustedLineHeight = uiFont.lineHeight * lineHeight
        let lineSpacing = adjustedLineHeight - uiFont.lineHeight
        let verticalPadding = lineSpacing / 2
        
        return content
            .font(Font.custom("VelaSans-Regular", size: size))
            .foregroundColor(Color("AccentDark"))
            .multilineTextAlignment(.leading)
            .lineSpacing(lineSpacing)
            .padding(.vertical, verticalPadding)
    }
}

extension View {
    func footnoteTextStyle() -> some View {
        self.modifier(FootnoteTextModifier())
    }
}
