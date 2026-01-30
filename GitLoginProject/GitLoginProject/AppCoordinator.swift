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

//    private let authManager: GithubAuthManager
    private let authState: AuthenticationState

    init(/*authManager: GithubAuthManager,*/ authState: AuthenticationState) {
//        self.authManager = authManager
        self.authState = authState
        self.flow = authState.isAuthenticated ? .main : .login
    }
    
    func onLoginSuccess() {
        flow = .main
    }

    func logout() {
        authState.logout()
        flow = .login
    }
}
