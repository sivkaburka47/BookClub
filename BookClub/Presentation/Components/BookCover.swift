//
//  BookCover.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct BookCover: View {
    let image: String

    var body: some View {
        AsyncImage(url: URL(string: image)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .frame(width: 80, height: 126)
                    .cornerRadius(4)
            case .failure:
                Rectangle()
                    .fill(Color.red.opacity(0.3))
                    .frame(width: 80, height: 126)
                    .cornerRadius(4)
                    .overlay(
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.red)
                    )
            case .empty:
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 126)
                    .cornerRadius(4)
                    .overlay(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .tint(.gray)
                    )
            @unknown default:
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 126)
                    .cornerRadius(4)
            }
        }
    }
}
