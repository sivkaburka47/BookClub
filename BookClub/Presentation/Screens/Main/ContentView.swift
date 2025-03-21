//
//  ContentView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isSignedIn = true
    @State private var selectedTab: Tab = .library
    
    var body: some View {
        if isSignedIn {
            NavigationView{
                ZStack {
                    Group {
                        switch selectedTab {
                        case .library: LibraryView()
                        case .search: SearchView()
                        case .player: MovieDetailsView()
                        case .bookmarks: BookmarksView()
                        case .logout: EmptyView()
                        }
                    }
                    
                    VStack {
                        Spacer()
                        CustomTabBar(selectedTab: $selectedTab) {
                            isSignedIn = false
                            selectedTab = .library
                        }
                    }
                }
                .toolbarBackground(.hidden, for: .navigationBar)
            }
        } else {
            SignInView(isSignedIn: $isSignedIn)
        }
    }
}


#Preview {
    ContentView()
}
