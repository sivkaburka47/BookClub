//
//  SectionTitle.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct SectionTitle: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.custom("AlumniSans-Bold", size: 24))
            .textCase(.uppercase)
            .foregroundColor(Color("AccentDark"))
            .multilineTextAlignment(.leading)
    }
}

