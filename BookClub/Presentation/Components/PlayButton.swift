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
                
                Image("Play")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.white)
            }
        }
    }
}
