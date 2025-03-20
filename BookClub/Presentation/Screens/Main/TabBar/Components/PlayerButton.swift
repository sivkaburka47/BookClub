//
//  PlayerButton.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct PlayerButton: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        NavigationLink(destination: ChapterView()) {
            Circle()
                .foregroundColor(Color("Secondary"))
                .frame(width: 80, height: 80)
                .overlay(
                    Image("Play")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                )
        }
        .contentShape(Circle())
        .offset(y: -10)
        .zIndex(1)
    }
}
