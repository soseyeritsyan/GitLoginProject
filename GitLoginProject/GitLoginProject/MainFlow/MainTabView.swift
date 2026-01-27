//
//  MainTabView.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 26.01.26.
//

import SwiftUI

struct MainTabView: View {

    let authManager: GithubAuthManager
    let authState: AuthState

    var body: some View {
        TabView {

            RepositoriesView()
                .tabItem {
                    Label("Repos", systemImage: "folder")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }

            SettingsView(viewModel: SettingsViewModel(authManager: authManager, authState: authState))
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
    }
}
