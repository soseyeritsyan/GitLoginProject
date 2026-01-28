//
//  RootView.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 27.01.26.
//

import SwiftUI

struct RootView: View {

    @StateObject private var authState: AuthState

    init() {
        let authManager = GithubAuthManager()
        _authState = StateObject(
            wrappedValue: AuthState(authManager: authManager)
        )
    }

    var body: some View {
        if authState.isAuthenticated {
            MainTabView(
                authManager: authState.authManager,
                authState: authState
            )
        } else {
            LoginView(authManager: authState.authManager)
                .environmentObject(authState)
        }
    }
}
