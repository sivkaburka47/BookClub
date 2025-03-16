//
//  LibraryView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        ZStack {
            AngularGradient(
                gradient: Gradient(colors: [.purple, .yellow, .green, .blue, .purple]),
                center: .center
            )
            .ignoresSafeArea()
            
            Text("Библиотека")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}
