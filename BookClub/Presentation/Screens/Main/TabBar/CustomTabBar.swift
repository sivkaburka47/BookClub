//
//  CustomTabBar.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    var onLogout: () -> Void
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                TabButton(icon: "Library", tab: .library, selectedTab: $selectedTab, animation: animation)
                Spacer()
                TabButton(icon: "Search", tab: .search, selectedTab: $selectedTab, animation: animation)
                Spacer()
                Spacer().frame(width: 80)
                Spacer()
                TabButton(icon: "Bookmarks", tab: .bookmarks, selectedTab: $selectedTab, animation: animation)
                Spacer()
                LogoutButton(action: onLogout)
                Spacer()
            }
            .frame(height: 64)
            .background(Color("AccentDark"))
            .cornerRadius(30)
            .padding(.horizontal)
            .padding(.bottom, 16)
            
            PlayerButton(selectedTab: $selectedTab)
        }
        .frame(height: 80)
    }
}

#Preview {
    ContentView()
}

