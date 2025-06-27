//
//  ImageLoader.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct ImageLoader: View {
    let imageUrlString: String
    @State private var isImageLoaded = false

    var body: some View {
        ZStack {
            if !isImageLoaded {
                GlassPlaceholder()
                    .transition(.opacity)
            }

            AsyncImage(url: URL(string: imageUrlString)) { phase in
                switch phase {
                case .success(let loadedImage):
                    loadedImage
                        .resizable()
                        .scaledToFill()
                        .opacity(isImageLoaded ? 1 : 0)
                        .scaleEffect(isImageLoaded ? 1 : 0.96)
                        .blur(radius: isImageLoaded ? 0 : 3)
                        .onAppear {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.75)) {
                                isImageLoaded = true
                            }
                        }

                case .failure:
                    ErrorPlaceholder()

                case .empty:
                    Color.clear

                @unknown default:
                    Color.clear
                }
            }
        }
        .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 5)
        .animation(.easeInOut, value: isImageLoaded)
    }
}
