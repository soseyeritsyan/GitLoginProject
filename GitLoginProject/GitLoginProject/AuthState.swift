//
//  AuthState.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 27.01.26.
//

import SwiftUI
import Combine

@MainActor
final class AuthState: ObservableObject {

    @Published private(set) var isAuthenticated: Bool

    private let _authManager: GithubAuthManager

    init(authManager: GithubAuthManager) {
        self._authManager = authManager
        self.isAuthenticated = authManager.isAuthenticated
    }

    var authManager: GithubAuthManager {
        _authManager
    }

    func loginSucceeded() {
        isAuthenticated = true
    }

    func logout() {
        _authManager.logout()
        isAuthenticated = false
    }
}
