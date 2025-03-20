//
//  ChapterView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 20.03.2025.
//

import SwiftUI

struct ChapterView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color("Secondary")
                .ignoresSafeArea()
            
            ScrollView {
                
            }
            .ignoresSafeArea()
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton(dismiss: dismiss)
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}
