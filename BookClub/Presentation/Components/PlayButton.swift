//
//  PlayButton.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct PlayButton: View {
    var body: some View {
        NavigationLink(destination: ChapterView()) {
            ZStack {
                Circle()
                    .fill(Color("AccentDark"))
                    .frame(width: 34, height: 34)
                
                CustomIcon(name: "Play", size: 16, color: Color("White"))
            }
        }
    }
}
