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

    private let authState: AuthenticationState

    init(authState: AuthenticationState) {
        self.authState = authState
    }

    func logout() {
        authState.logout()
    }
}


struct SettingsView: View {

    @EnvironmentObject private var authState: AuthenticationState

    var body: some View {
        SettingsViewContent(authState: authState)
    }
}

private struct SettingsViewContent: View {

    let authState: AuthenticationState
    @StateObject private var viewModel: SettingsViewModel

    init(authState: AuthenticationState) {

        self.authState = authState
        _viewModel = StateObject(
            wrappedValue: SettingsViewModel(
                authState: authState
            )
        )
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {

                Button(role: .destructive) {
                    viewModel.logout()
                } label: {
                    Text("Log Out")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)

            }
            .padding()
            .navigationTitle("Settings")
        }
    }
}
