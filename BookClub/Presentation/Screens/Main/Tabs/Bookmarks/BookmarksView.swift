//
//  BookmarksView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct BookmarksView: View {
    var body: some View {
        ZStack {
            AngularGradient(
                gradient: Gradient(colors: [.green, .yellow, .green, .blue, .purple]),
                center: .center
            )
            .ignoresSafeArea()
            
            Text("Закладки")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}
