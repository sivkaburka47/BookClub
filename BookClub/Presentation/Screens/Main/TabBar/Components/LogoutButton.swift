//
//  LogoutButton.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct LogoutButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image("LogOut")
                .renderingMode(.template)
                .foregroundColor(Color("AccentMedium"))
        }
    }
}
