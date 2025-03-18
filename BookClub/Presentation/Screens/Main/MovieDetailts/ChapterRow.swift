//
//  ChapterRow.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 18.03.2025.
//

import SwiftUI

struct ChapterRow: View {
    let chapter: String
    let isActive: Bool
    let isRead: Bool
    
    var body: some View {
        HStack {
            Text(chapter)
                .font(Font.custom(isActive ? "VelaSans-Bold" : "VelaSans-Regular", size: 16))
                .foregroundColor(Color("AccentDark"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if isActive {
                Image("ReadingNow")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color("AccentDark"))
            } else if isRead {
                Image("Read")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color("AccentMedium"))
            }
        }
        .padding(.vertical, 8)
    }
}
