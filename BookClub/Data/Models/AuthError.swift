//
//  AuthError.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 30.06.2025.
//

import Foundation

enum AuthError: LocalizedError {
    case invalidCredentials(String)
    case networkError(Error)
    case serverError(status: Int, message: String)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidCredentials(let message):
            return message
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .serverError(_, let message):
            return message
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}
