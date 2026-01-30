//
//  LoginViewModel.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 18.01.26.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {

    private let authState: AuthenticationState

    init(authState: AuthenticationState) {
        self.authState = authState
    }

    func signIn(username: String?, token: String) async throws {
        guard !token.isEmpty else {
            throw AuthError.invalidToken
        }
        
        try await authState.login(username: username, token: token)
    }
}
