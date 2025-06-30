//
//  ProgressRepositoryImpl.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 22.06.2025.
//

final class ProgressRepositoryImpl {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
}

extension ProgressRepositoryImpl: ProgressRepository {

    func getProgress() async throws -> [Progress] {
        let endpoint = ProgressEndpoint.getProgress
        let response: ProgressReponseDTO = try await httpClient.sendRequest(endpoint: endpoint, requestBody: nil as EmptyRequestModel?)

        return response.data.map { $0.toDomain() }
    }

    func saveProgress(progress: Progress) async throws {
        let endpoint = ProgressEndpoint.saveProgress
        let request = ProgressRequestDTO(data: .init(value: progress.value, chapterId: progress.chapterId))

        try await httpClient.sendRequestWithoutResponse(endpoint: endpoint, requestBody: request)
    }

    func updateProgress(documentId: String, progress: Progress) async throws {
        let endpoint = ProgressEndpoint.updateProgress(documentId: documentId)
        let request = ProgressRequestDTO(data: .init(value: progress.value, chapterId: progress.chapterId))

        try await httpClient.sendRequestWithoutResponse(endpoint: endpoint, requestBody: request)
    }
}
