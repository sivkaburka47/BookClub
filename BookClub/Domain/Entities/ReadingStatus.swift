//
//  ReadingStatus.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 28.06.2025.
//

struct ReadingStatus: Identifiable {
    let id: Int
    let bookId: Int
    let bookTitle: String
    let bookImageUrl: String
    let chapterTitle: String
    var value: Double

    var normalizedProgress: Double {
        (value / 100.0).clamped(to: 0.0...1.0)
    }
}

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
