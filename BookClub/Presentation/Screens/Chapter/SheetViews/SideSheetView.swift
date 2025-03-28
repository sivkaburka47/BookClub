//
//  SideSheetView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 25.03.2025.
//

import SwiftUI

struct SideSheetView: View {
    @Environment(\.dismiss) var dismiss
    let chapters: [Chapter]
    @Binding var activeChapter: Int
    @Binding var isShowingSheet: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                chaptersList
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton(dismiss: dismiss, style: .dark)
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Оглавление")
                        .h2TextStyle()
                }
            }
            .toolbarBackground(Color("Background"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
        .ignoresSafeArea()
    }
}

private extension SideSheetView {
    @ViewBuilder
    var chaptersList: some View {
        VStack(spacing: 0) {
            ForEach(chapters.indices, id: \.self) { index in
                chapterRow(chapter: chapters[index].title,
                            isActive: activeChapter == index)
                .contentShape(Rectangle())
                .onTapGesture {
                    activeChapter = index
                    isShowingSheet = false
                }
            }
        }
    }
    
    @ViewBuilder
    func chapterRow(chapter: String, isActive: Bool) -> some View {
        HStack {
            Text(chapter)
                .font(.custom(isActive ? "VelaSans-Bold" : "VelaSans-Regular", size: 16))
                .bodyTextStyle()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
        
    }
}
