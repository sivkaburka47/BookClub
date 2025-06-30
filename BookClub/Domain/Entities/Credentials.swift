//
//  Credentials.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

struct Credentials {
    let email: String
    let password: String

    init(email: String = "", password: String = "") {
        self.email = email
        self.password = password
    }
}
