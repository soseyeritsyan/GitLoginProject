//
//  SettingsView.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 26.01.26.
//

import SwiftUI
import Combine



@MainActor
final class SettingsViewModel: ObservableObject {

    private let authManager: GithubAuthManager
    private let authState: AuthState

    @Published var profileImageData: Data?

    init(authManager: GithubAuthManager, authState: AuthState) {
        self.authManager = authManager
        self.authState = authState
    }

    func logout() {
        authState.logout()
    }
}



struct SettingsView: View {
    
    @StateObject var viewModel: SettingsViewModel
    
    var body: some View {
        NavigationStack {
            Button(role: .destructive) {
                viewModel.logout()
            } label: {
                Text("Log out")
            }
        }
        .navigationTitle("Settings")
    }
}
