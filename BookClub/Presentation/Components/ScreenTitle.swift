//
//  ScreenTitle.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct ScreenTitle: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.custom("AlumniSans-Bold", size: 48))
            .textCase(.uppercase)
            .foregroundColor(Color("Secondary"))
    }
}
