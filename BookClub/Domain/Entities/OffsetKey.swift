//
//  OffsetKey.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 28.06.2025.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
