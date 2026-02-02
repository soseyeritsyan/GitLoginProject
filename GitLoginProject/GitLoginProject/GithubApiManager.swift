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


final class GithubApiManager {
    
    private let keychain = KeychainService()
    private let credentialsKey = "github_token_credentials"
    
    private let baseURL = "https://api.github.com"
    private let authUrlPath = "/user"
    private let reposPath = "/user/repos"
    
    private let perPage = 20
    
    var hasValidCredentials: Bool {
        currentToken() != nil
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
    
    func fetchAuthenticatedUser() async throws -> UserModel {
        guard let token = currentToken() else {
            throw AuthError.invalidToken
        }
        
        guard let url = URL(string:  baseURL + authUrlPath)  else {
            throw AuthError.invalidResponse
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw AuthError.invalidResponse
        }
        
        return try JSONDecoder().decode(UserModel.self, from: data)
    }
    
    private func validateToken(_ token: String) async throws {
        guard let url = URL(string:  baseURL + authUrlPath)  else {
            throw AuthError.invalidResponse
        }
        var request = URLRequest(url: url)
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse else {
            throw AuthError.invalidResponse
        }
        
        guard http.statusCode == 200 else {
            throw AuthError.invalidToken
        }
    }
    
    
    
    func fetchRepositories(page: Int) async throws -> [Repository] {
        guard let token = currentToken() else {
            throw AuthError.invalidToken
        }
        
        guard let url = URL(string:  baseURL + reposPath)  else {
            throw AuthError.invalidResponse
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw AuthError.invalidResponse
        }
        components.queryItems = [
            .init(name: "page", value: "\(page)"),
            .init(name: "per_page", value: "\(perPage)")
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([Repository].self, from: data)
    }
    
}
