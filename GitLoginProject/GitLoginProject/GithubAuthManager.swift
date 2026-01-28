//
//  GitApiManager.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 18.01.26.
//

import Foundation

struct GithubCredentials: Codable {
    let token: String
    let username: String?
}


enum AuthError: LocalizedError {
    case invalidToken
    case forbidden
    case invalidResponse
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidToken:
            return "Invalid or expired GitHub token."
        case .forbidden:
            return "Access forbidden. Check token permissions or rate limits."
        case .invalidResponse:
            return "Invalid server response."
        case .unknown:
            return "Unexpected authentication error."
        }
    }
}



final class GithubAuthManager {
    
    private let keychain: KeychainService = KeychainService()
    private let credentialsKey = "github_token_credentials"
    
    private let authUrlString = "https://api.github.com/user"

    init() {}

    var isAuthenticated: Bool {
        keychain.read(key: credentialsKey) != nil
    }

    func currentToken() -> String? {
        guard let data = keychain.read(key: credentialsKey),
              let creds = try? JSONDecoder().decode(GithubCredentials.self, from: data)
        else { return nil }

        return creds.token
    }

    func login(username: String?, token: String) async throws {
        try await validateToken(token)
        let creds = GithubCredentials(token: token, username: username)
        keychain.save(creds, key: credentialsKey)
    }

    func logout() {
        keychain.delete(key: credentialsKey)
    }

    private func validateToken(_ token: String) async throws {
        guard let url = URL(string: authUrlString) else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw AuthError.invalidResponse
        }

        switch http.statusCode {
        case 200:
            return
        case 401:
            throw AuthError.invalidToken
        case 403:
            throw AuthError.forbidden
        default:
            throw AuthError.unknown
        }
    }
}

