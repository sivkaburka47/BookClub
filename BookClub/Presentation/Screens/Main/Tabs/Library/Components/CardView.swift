//
//  CardView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct CardView: View {
    let cardImage: String
    let title: String
    let author: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(cardImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .cornerRadius(4)
            
            VStack(alignment: .leading){
                Text(title)
                    .font(.custom("AlumniSans-Bold", size: 14))
                    .foregroundColor(Color("Secondary"))
                    .multilineTextAlignment(.leading)
                
                Text(author)
                    .font(.custom("VelaSans-Regular", size: 10))
                    .foregroundColor(Color("AccentDark"))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .frame(maxHeight: .infinity)
        }
    }
}
