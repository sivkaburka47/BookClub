//
//  ChapterView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 20.03.2025.
//

import SwiftUI

struct ChapterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isPlaying = false
    
    var body: some View {
        ZStack {
            Color("AccentDark")
                .ignoresSafeArea()
            VStack(spacing: 0) {
                ScrollView {
                    
                }
                .background(Color("Background"))
                
                HStack {
                    HStack (spacing: 8) {
                        CustomIcon(name: "Previous", size: 24, color: "White")
                            .padding(8)
                        
                        CustomIcon(name: "Contents", size: 24, color: "White")
                            .padding(8)
                        
                        CustomIcon(name: "Next", size: 24, color: "White")
                            .padding(8)
                        
                        CustomIcon(name: "Settings", size: 24, color: "White")
                            .padding(8)
                    }
                    Spacer()
                    Button(action: {
                        isPlaying.toggle()
                    }) {
                        Circle()
                            .fill(Color("AccentLight"))
                            .frame(width: 50, height: 50)
                            .overlay(
                                CustomIcon(
                                    name: isPlaying ? "Pause" : "Play",
                                    size: 24,
                                    color: "AccentDark"
                                )
                            )
                    }
                    
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton(dismiss: dismiss, style: .dark)
            }
            
            ToolbarItem(placement: .principal) {
                VStack {
                    SectionTitle(text: "Код Да Винчи")
                    SecondaryText(text: "Пролог", lineHeight: 1.5, size: 14)
                }
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}
