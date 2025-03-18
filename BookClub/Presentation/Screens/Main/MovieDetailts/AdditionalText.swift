//
//  AdditionalText.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 18.03.2025.
//

import SwiftUI

struct AdditionalText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.custom("VelaSans-Regular", size: 16))
            .lineSpacing(16 * 1.3 - 16)
            .foregroundColor(Color("AccentDark"))
    }
}
