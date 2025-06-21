//
//  ProgressEndpoint.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Foundation
import Alamofire
import KeychainAccess

enum ProgressEndpoint: APIEndpoint {
    case getProgress
    case saveProgress
    case updateProgress(documentId: String)

    var path: String {
        switch self {
        case .getProgress:
            return "/progresses"
        case .saveProgress:
            return "/progresses"
        case .updateProgress(let documentId):
            return "/progresses/\(documentId)"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .getProgress:
            return .get
        case .saveProgress:
            return .post
        case .updateProgress:
            return .put
        }
    }

    var parameters: Alamofire.Parameters? { nil }

    var headers: Alamofire.HTTPHeaders? {
        guard let token = authToken else { return nil }
        return ["Authorization": "Bearer \(token)"]
    }

    private var authToken: String? {
        let keychain = Keychain()
        return try? keychain.get("authToken")
    }
}
