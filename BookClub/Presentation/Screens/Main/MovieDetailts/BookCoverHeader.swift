//
//  BookCoverHeader.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 18.03.2025.
//

import SwiftUI

struct BookCoverHeader: View {
    let image: String
    
    var body: some View {
        GeometryReader { geometry in
            let offsetY = geometry.frame(in: .global).minY
            let height = UIScreen.main.bounds.width * 0.93 + (offsetY > 0 ? offsetY : 0)
            
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: height)
                .clipped()
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color("Background"), .clear]),
                        startPoint: .bottom,
                        endPoint: .center
                    )
                )
                .offset(y: offsetY > 0 ? -offsetY : 0)
        }
        .frame(height: UIScreen.main.bounds.width * 0.93)
    }
}
