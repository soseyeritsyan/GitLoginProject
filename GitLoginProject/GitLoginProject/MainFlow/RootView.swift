//
//  RootView.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 27.01.26.
//

import SwiftUI

struct RootView: View {

    @EnvironmentObject private var authState: AuthenticationState

    var body: some View {
        RootViewContent(authState: authState)
    }
}

private struct RootViewContent: View {

    @ObservedObject var authState: AuthenticationState
    
    init(authState: AuthenticationState) {
        self.authState = authState
    }

    var body: some View {
        Group {
            if authState.isAuthenticated {
                MainTabView()
            } else {
                LoginView(authState: authState)
            }
        }
        .task {
            if authState.isAuthenticated {
                await authState.loadUser()
            }
        }
    }
}
