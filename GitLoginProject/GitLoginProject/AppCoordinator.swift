//
//  AppCoordinator.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 24.01.26.
//

import SwiftUI
import Combine

enum AppFlow {
    case login
    case main
}

//@MainActor
final class AppCoordinator: ObservableObject {
    
    @Published private(set) var flow: AppFlow = .login

    private let authManager: GithubAuthManager

    init(authManager: GithubAuthManager) {
        self.authManager = authManager
        self.flow = authManager.isAuthenticated ? .main : .login
    }
    
    func onLoginSuccess() {
        flow = .main
    }

    func logout() {
        authManager.logout()
        flow = .login
    }
}
