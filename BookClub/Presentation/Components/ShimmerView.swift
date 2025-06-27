//
//  ShimmerView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 28.06.2025.
//

import SwiftUI

struct GlassPlaceholder: View {
    @State private var shimmer = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(
                    .ultraThinMaterial
                )
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.2))
                )
                .overlay(
                    ShimmerOverlay(shimmer: $shimmer)
                )
                .onAppear {
                    withAnimation(Animation.linear(duration: 1.8).repeatForever(autoreverses: false)) {
                        shimmer = true
                    }
                }
        }
    }
}

struct ShimmerOverlay: View {
    @Binding var shimmer: Bool

    var body: some View {
        GeometryReader { geo in
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white.opacity(0.05), Color.white.opacity(0.4), Color.white.opacity(0.05)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .rotationEffect(.degrees(30))
                .offset(x: shimmer ? geo.size.width : -geo.size.width)
        }
        .clipped()
    }
}
