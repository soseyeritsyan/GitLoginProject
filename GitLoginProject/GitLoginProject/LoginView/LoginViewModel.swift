//
//  LoginViewModel.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 18.01.26.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {

    private let authManager: GithubAuthManager
    var onLoginSuccess: (() -> Void)?

    init(authManager: GithubAuthManager) {
        self.authManager = authManager
    }

    func signIn(username: String?, token: String) async throws {
        try await authManager.login(username: username, token: token)
        onLoginSuccess?()
    }
}
