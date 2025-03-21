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
    let authors: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(cardImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .cornerRadius(4)
            
            VStack(alignment: .leading, spacing: 4){
                Text(title)
                    .font(Font.custom("AlumniSans-Bold", size: 14))
                    .foregroundColor(Color("AccentDark"))
                    .textCase(.uppercase)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(authors.joined(separator: ", "))
                    .font(.custom("VelaSans-Regular", size: 10))
                    .foregroundColor(Color("AccentDark"))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
        }
        
    }
}
