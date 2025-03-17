//
//  RecentRequestsView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 17.03.2025.
//

import SwiftUI

struct RecentRequestsView: View {
    @Binding var recentRequests: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionTitle(text: "Недавние запросы")
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(recentRequests, id: \.self) { request in
                    HStack {
                        Image("History")
                            .renderingMode(.template)
                            .foregroundColor(Color("AccentDark"))
                            .frame(width: 24, height: 24)
                        
                        Text(request)
                            .font(Font.custom("VelaSans-Regular", size: 14))
                            .foregroundColor(Color("AccentDark"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button(action: {
                            recentRequests.removeAll { $0 == request }
                        }) {
                            Image("Close")
                                .renderingMode(.template)
                                .foregroundColor(Color("AccentDark"))
                                .frame(width: 24, height: 24)
                        }
                        .padding(8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                    .background(Color("AccentLight"))
                    .cornerRadius(8)
                }
            }
        }
    }
}
