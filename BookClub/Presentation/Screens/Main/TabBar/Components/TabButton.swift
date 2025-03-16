//
//  TabButton.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI

struct TabButton: View {
    let icon: String
    let tab: Tab
    @Binding var selectedTab: Tab
    var animation: Namespace.ID
    
    var body: some View {
        Button {
            withAnimation(.spring()) {
                selectedTab = tab
            }
        } label: {
            Image(icon)
                .renderingMode(.template)
                .foregroundColor(selectedTab == tab ? .white : Color("AccentMedium"))
        }
    }
}
