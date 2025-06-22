//
//  ProgressRequestDTO.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation

struct ProgressRequestDTO: Encodable {
    let data: ProgressDataDTO

    struct ProgressDataDTO: Encodable {
        let value: Int
        let chapterId: Int
    }
}
