//
//  BodySmallTextModifier.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.03.2025.
//

import SwiftUI

struct BodySmallTextModifier: ViewModifier {
    let size: CGFloat = 14
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
    func bodySmallTextStyle() -> some View {
        self.modifier(BodySmallTextModifier())
    }
}
