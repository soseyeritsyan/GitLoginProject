//
//  AuthenticationState.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 27.01.26.
//

import SwiftUI
import Combine

@MainActor
final class AuthenticationState: ObservableObject {

    @Published private(set) var isAuthenticated: Bool
    @Published private(set) var user: UserModel?

    private let authManager = GithubApiManager()

    init() {
        self.isAuthenticated = authManager.hasValidCredentials
    }

    func login(username: String?, token: String) async throws {
        try await authManager.login(username: username, token: token)
        isAuthenticated = true
        await loadUser()
    }

    func logout() {
        authManager.logout()
        isAuthenticated = false
        user = nil
    }

    func loadUser() async {
        do {
            user = try await authManager.fetchAuthenticatedUser()
            print("User loaded: \(user?.login ?? "")")
        } catch {
            logout()
            print("Failed to load user")
        }
    }
}
