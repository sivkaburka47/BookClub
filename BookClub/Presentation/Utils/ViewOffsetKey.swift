//
//  ViewOffsetKey.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 24.03.2025.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
