//
//  ContentView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 16.03.2025.
//

import SwiftUI
import KeychainAccess

struct ContentView: View {
    @State private var isSignedIn = false
    @State private var selectedTab: Tab = .library

    private func checkToken() {
        let keychain = Keychain()
        if keychain["authToken"] != nil {
            isSignedIn = true
        } else {
            isSignedIn = false
        }
    }

    var body: some View {
        Group {
            if isSignedIn {
                NavigationView {
                    ZStack {
                        Group {
                            switch selectedTab {
                            case .library: LibraryView()
                            case .search: SearchView()
                            case .player: EmptyView()
                            case .bookmarks: BookmarksView()
                            case .logout:
                                Color.clear
                                    .onAppear {
                                        let keychain = Keychain()
                                        try? keychain.remove("authToken")
                                        isSignedIn = false
                                        selectedTab = .library
                                    }
                            }
                        }

                        VStack {
                            Spacer()
                            CustomTabBar(selectedTab: $selectedTab) {
                                let keychain = Keychain()
                                try? keychain.remove("authToken")
                                isSignedIn = false
                                selectedTab = .library
                            }
                        }
                        .ignoresSafeArea(.keyboard)
                    }
                    .toolbarBackground(.hidden, for: .navigationBar)
                }
            } else {
                SignInView(isSignedIn: $isSignedIn)
            }
        }
        .onAppear(perform: checkToken)
    }
}
