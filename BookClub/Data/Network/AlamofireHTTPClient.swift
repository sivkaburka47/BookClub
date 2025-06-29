//
//  AlamofireHTTPClient.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 21.06.2025.
//

import Alamofire
import Foundation
import os

final class AlamofireHTTPClient: HTTPClient {
    private let baseURL = "https://brilliant-delight-92875246ff.strapiapp.com/api"
    private let logger = Logger(subsystem: "com.bookclub.network", category: "HTTPClient")

    func sendRequest<T: Decodable, U: Encodable>(endpoint: APIEndpoint, requestBody: U? = nil) async throws -> T {
        let url = baseURL + endpoint.path
        let method = endpoint.method
        let headers = endpoint.headers

        logRequest(url: url, method: method, headers: headers, body: requestBody)

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: method, parameters: requestBody, encoder: JSONParameterEncoder.default, headers: headers)
                .validate()
                .responseDecodable(of: T.self) { response in
                    self.logResponse(response: response, endpoint: endpoint)

                    switch response.result {
                    case .success(let decodedData):
                        continuation.resume(returning: decodedData)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }

    func sendRequestWithoutResponse<U: Encodable>(endpoint: APIEndpoint, requestBody: U? = nil) async throws {
        let url = baseURL + endpoint.path
        let method = endpoint.method
        let headers = endpoint.headers

        logRequest(url: url, method: method, headers: headers, body: requestBody)

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: method, parameters: requestBody, encoder: JSONParameterEncoder.default, headers: headers)
                .validate()
                .response { response in
                    self.logResponse(response: response, endpoint: endpoint)

                    switch response.result {
                    case .success:
                        continuation.resume()
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }

    private func logRequest<U: Encodable>(url: String, method: HTTPMethod, headers: HTTPHeaders?, body: U?) {
        var logMessage = "➡️ Request: \(method.rawValue) \(url)"

        if let headers = headers, !headers.isEmpty {
            logMessage += "\nHeaders: \(headers.dictionary)"
        }

        if let body = body {
            if let jsonData = try? JSONEncoder().encode(body),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                logMessage += "\nBody: \(jsonString)"
            } else {
                logMessage += "\nBody: Unable to encode body"
            }
        }

        logger.info("\(logMessage)")
    }

    private func logResponse<T>(response: DataResponse<T, AFError>, endpoint: APIEndpoint) {
        let statusCode = response.response?.statusCode ?? 0
        var logMessage = "⬅️ Response: \(endpoint.method.rawValue) \(endpoint.path) - Status: \(statusCode)"

        if let data = response.data {
            if let jsonObject = try? JSONSerialization.jsonObject(with: data),
               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
               let prettyString = String(data: prettyData, encoding: .utf8) {
                logMessage += "\nResponse Body:\n\(prettyString)"
            } else if let rawString = String(data: data, encoding: .utf8) {
                logMessage += "\nResponse Body (raw):\n\(rawString)"
            } else {
                logMessage += "\nResponse Body: Unable to decode data"
            }
        } else {
            logMessage += "\nResponse Body: No data"
        }

        if let error = response.error {
            logMessage += "\nError: \(error.localizedDescription)"
        }

        logger.info("\(logMessage)")
    }
}
