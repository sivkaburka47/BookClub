//
//  SearchView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack {
            AngularGradient(
                gradient: Gradient(colors: [.blue, .yellow, .green, .blue, .purple]),
                center: .center
            )
            .ignoresSafeArea()
            
            Text("Поиск")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}
