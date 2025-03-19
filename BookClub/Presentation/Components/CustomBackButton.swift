//
//  CustomBackButton.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 19.03.2025.
//

import SwiftUI

struct CustomBackButton: View {
    let dismiss: DismissAction
    
    var body: some View {
        Button(action: { dismiss() }) {
            HStack(spacing: 6) {
                Image("ArrowLeft")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color("White"))
                
                Text("Назад")
                    .font(.system(size: 17))
                    .foregroundColor(Color("White"))
            }
        }
    }
}
