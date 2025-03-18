//
//  ProgressLine.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 18.03.2025.
//

import SwiftUI

struct ProgressLine: View {
    var progress: Double
    
    var body: some View {
        ProgressView(value: progress)
            .progressViewStyle(LinearProgressViewStyle())
            .tint(Color("AccentDark"))
            .background(Color("AccentMedium"))
            .cornerRadius(4)
    }
}
