//
//  SecondaryText.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 19.03.2025.
//

import SwiftUI

struct SecondaryText: View {
    let text: String
    let lineHeight: Double
    let size: CGFloat
    
    var body: some View {
        Text(text)
            .font(Font.custom("VelaSans-Regular", size: size))
            .foregroundColor(Color("AccentDark"))
            .multilineTextAlignment(.leading)
            .lineSpacing(size * (lineHeight / 100) - size)
    }
}
