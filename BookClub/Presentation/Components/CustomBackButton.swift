//
//  CustomBackButton.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 19.03.2025.
//

import SwiftUI


struct CustomBackButton: View {
    let dismiss: DismissAction
    let style: BackButtonStyle
    
    enum BackButtonStyle {
        case light, dark
    }
    
    var body: some View {
        Button(action: { dismiss() }) {
            HStack(spacing: 6) {
                Image("ArrowLeft")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(textColor)
                
                Text("Назад")
                    .font(.system(size: 17))
                    .foregroundColor(textColor)
            }
        }
    }
    
    private var textColor: Color {
        style == .dark ? Color("AccentDark") : Color("White")
    }
}
