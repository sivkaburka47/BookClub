//
//  SecondaryBoldText.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 19.03.2025.
//

import SwiftUI

struct SecondaryBoldText: View {
    let text: String
    let lineHeight: Double
    let size: CGFloat
    
    var body: some View {
        Text(text)
            .font(Font.custom("VelaSans-Bold", size: size))
            .foregroundColor(Color("AccentDark"))
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineSpacing(size * (lineHeight / 100) - size)
    }
}
