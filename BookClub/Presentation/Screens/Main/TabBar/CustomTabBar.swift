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
                tabButton(icon: "Library", tab: .library, selectedTab: $selectedTab, animation: animation)
                Spacer()
                tabButton(icon: "Search", tab: .search, selectedTab: $selectedTab, animation: animation)
                Spacer()
                Spacer().frame(width: 80)
                Spacer()
                tabButton(icon: "Bookmarks", tab: .bookmarks, selectedTab: $selectedTab, animation: animation)
                Spacer()
                logoutButton(action: onLogout)
                Spacer()
            }
            .frame(height: 64)
            .background(Color("AccentDark"))
            .cornerRadius(30)
            .padding(.horizontal)
            .padding(.bottom, 16)
            
            playerButton(selectedTab: $selectedTab)
        }
        .frame(height: 80)
    }
}

// MARK: View Components
private extension CustomTabBar {
    @ViewBuilder
    func logoutButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            CustomIcon(name: "LogOut", size: 24, color: Color("AccentMedium"))
        }
    }
    
    @ViewBuilder
    func playerButton(selectedTab: Binding<Tab>) -> some View {
        NavigationLink(destination: ChapterView()) {
            Circle()
                .foregroundColor(Color("Secondary"))
                .frame(width: 80, height: 80)
                .overlay(
                    CustomIcon(name: "Play", size: 24, color: Color("White"))
                )
        }
        .contentShape(Circle())
        .offset(y: -10)
        .zIndex(1)
    }
    
    @ViewBuilder
    func tabButton(icon: String, tab: Tab, selectedTab: Binding<Tab>, animation: Namespace.ID) -> some View {
        Button {
            withAnimation(.spring()) {
                selectedTab.wrappedValue = tab
            }
        } label: {
            CustomIcon(name: icon, size: 24, color: selectedTab.wrappedValue == tab ? Color("White") : Color("AccentMedium"))
        }
    }
}
