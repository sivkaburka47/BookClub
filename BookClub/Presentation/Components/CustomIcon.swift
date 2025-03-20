//
//  CustomIcon.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 20.03.2025.
//

import SwiftUI

struct CustomIcon: View {
    let name: String
    let size: CGFloat
    let color: String
    
    var body: some View {
        Image(name)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundColor(Color(color))
    }
}
