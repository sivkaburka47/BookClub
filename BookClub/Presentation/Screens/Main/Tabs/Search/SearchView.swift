//
//  SearchView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    
    let genres = [
        "Классика", "Фэнтези", "Фантастика", "Детектив",
        "Триллер", "Исторический роман", "Любовный роман", "Приключения",
        "Поэзия", "Биография", "Для подростков", "Для детей"
    ]
    
    @State private var recentRequests = ["Android", "iOS", "Windows", "Linux", "MacOS"]
    
    @State private var authors = [
        Author(image: "book", name: "Братья Стругацкие"),
        Author(image: "book", name: "Дэн Браун"),
        Author(image: "book", name: "Федор Достоевский"),
        Author(image: "book", name: "Эйнштейн"),
        Author(image: "book", name: "Лев Толстой")
    ]
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    CustomSearchBar(text: $searchText)
                    

                    
                    Spacer().frame(height: 100)
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    SearchView()
}
