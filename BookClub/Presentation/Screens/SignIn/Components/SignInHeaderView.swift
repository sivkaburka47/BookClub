//
//  SignInHeaderView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct SignInHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("открой для себя")
                .font(.custom("AlumniSans-Bold", size: 48))
                .textCase(.uppercase)
                .foregroundColor(Color("AccentLight"))
            
            Text("книжный мир")
                .font(.custom("AlumniSans-Bold", size: 96))
                .textCase(.uppercase)
                .foregroundColor(Color("Secondary"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
}
