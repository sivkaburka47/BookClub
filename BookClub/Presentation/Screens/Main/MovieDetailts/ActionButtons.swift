//
//  ActionButtons.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 18.03.2025.
//

import SwiftUI

struct ActionButtons: View {
    var body: some View {
        HStack(spacing: 8) {
            NavigationLink(destination: ChapterView()) {
                HStack(alignment: .center, spacing: 8) {
                    Image("Play")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color("White"))
                        
                    Text("Читать")
                        .font(.custom("VelaSans-Bold", size: 17))
                        .foregroundColor(Color("White"))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color("AccentDark"))
                .cornerRadius(12)
            }
            
            Button(action: {}) {
                HStack(alignment: .center, spacing: 8) {
                    Image("Bookmarks")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color("AccentDark"))
                        
                    Text("В избранное")
                        .font(.custom("VelaSans-Bold", size: 17))
                        .foregroundColor(Color("AccentDark"))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color("AccentLight"))
                .cornerRadius(12)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .offset(y: -25)
    }
}

