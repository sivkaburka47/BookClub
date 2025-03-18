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
    }
    
    let text: String
    let style: TitleStyle
    
    var body: some View {
        Text(text)
            .font(.custom("AlumniSans-Bold", size: 48))
            .textCase(.uppercase)
            .foregroundColor(style == .red ? Color("Secondary") : Color("AccentDark"))
    }
}
