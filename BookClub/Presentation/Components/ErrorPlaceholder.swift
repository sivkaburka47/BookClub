//
//  ErrorPlaceholder.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 28.06.2025.
//

import SwiftUI

struct ErrorPlaceholder: View {
    @State private var pulse = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.red.opacity(0.08))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(
                            LinearGradient(colors: [Color.red.opacity(0.4), Color.red.opacity(0.1)],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing),
                            lineWidth: 1.2
                        )
                )
                .shadow(color: .red.opacity(0.1), radius: 12, x: 0, y: 6)

            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(gradient: Gradient(colors: [Color.red.opacity(0.3), Color.clear]),
                                           center: .center,
                                           startRadius: 5,
                                           endRadius: 40)
                        )
                        .scaleEffect(pulse ? 1.15 : 0.85)
                        .opacity(pulse ? 0.6 : 0.4)
                        .animation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: pulse)

                    Image(systemName: "xmark.octagon.fill")
                        .font(.system(size: 44, weight: .semibold))
                        .foregroundStyle(LinearGradient(colors: [.red, .pink], startPoint: .top, endPoint: .bottom))
                        .shadow(color: .red.opacity(0.4), radius: 6, x: 0, y: 3)
                }

                VStack(spacing: 4) {
                    Text("Ошибка загрузки")
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text("Проверьте соединение\nили попробуйте позже.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 16)
        }
        .onAppear {
            pulse = true
        }
    }
}
