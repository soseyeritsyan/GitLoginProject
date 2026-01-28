//
//  GitLoginProjectApp.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 08.01.26.
//

import SwiftUI
import SwiftData

@main
struct GitLoginProjectApp: App {
    let authManager = GithubAuthManager()
    let authState: AuthState
    
    init() {
        let manager = GithubAuthManager()
        self.authState = AuthState(authManager: manager)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authState)
        }
    }
}
