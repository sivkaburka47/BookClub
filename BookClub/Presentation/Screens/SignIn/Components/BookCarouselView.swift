//
//  BookCarouselView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct BookCarouselView: View {
    @State private var offset: CGFloat = 0
    let bookCovers = Array(repeating: "book", count: 5)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(0..<bookCovers.count * 10, id: \.self) { index in
                    Image(bookCovers[index % bookCovers.count])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 172, height: 270)
                        .cornerRadius(4)
                }
            }
            .offset(x: offset)
            .animation(.linear(duration: 300).repeatForever(autoreverses: false), value: offset)
            .onAppear {
                offset = -172 * CGFloat(bookCovers.count * 10)
            }
        }
        .frame(height: 270)
        .allowsHitTesting(false)
    }
}
