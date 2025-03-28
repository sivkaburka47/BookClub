//
//  SettingsSheetView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 25.03.2025.
//

import SwiftUI

struct SettingsSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isShowingSettingSheet: Bool
    @Binding var fontSize: Double
    @Binding var paddingSize: Double
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                fontSizeMenu
                
                paddingSizeMenu
                Spacer()
            }
            .padding(.horizontal, 16)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingSettingSheet.toggle()
                    }, label: {
                        CustomIcon(name: "Close", size: 24, color: Color("AccentDark"))
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Настройки")
                        .h2TextStyle()
                }
            }
            .toolbarBackground(Color("Background"), for: .navigationBar)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
        .ignoresSafeArea()
    }
}

private extension SettingsSheetView {
    var fontSizeMenu: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Размер шрифта")
                .bodyTextStyle()
            HStack {
                Text("\(Int(fontSize)) пт")
                    .font(.custom("VelaSans-Bold", size: 16))
                    .bodyTextStyle()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Stepper(value: $fontSize, in: 6...30, step: 1) {
                    EmptyView()
                }
                .labelsHidden()
            }
        }
    }
    
    var paddingSizeMenu: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Расстония между строками")
                .bodyTextStyle()
            HStack {
                Text("\(Int(paddingSize)) пт")
                    .font(.custom("VelaSans-Bold", size: 16))
                    .bodyTextStyle()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Stepper(value: $paddingSize, in: 6...30, step: 1) {
                    EmptyView()
                }
                .labelsHidden()
            }
        }
    }
}
