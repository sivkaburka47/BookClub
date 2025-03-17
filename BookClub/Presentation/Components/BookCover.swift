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
        Image(image)
            .resizable()
            .frame(width: 80, height: 126)
            .cornerRadius(4)
    }
}
