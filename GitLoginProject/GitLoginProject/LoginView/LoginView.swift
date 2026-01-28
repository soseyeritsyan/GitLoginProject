//
//  LoginView.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 08.01.26.
//

import SwiftUI

struct LoginView: View {

    @EnvironmentObject private var authState: AuthState
    @StateObject private var viewModel: LoginViewModel

    init(authManager: GithubAuthManager) {
        _viewModel = StateObject(
            wrappedValue: LoginViewModel(authManager: authManager)
        )
    }

    var body: some View {
        LoginViewWrapper(viewModel: viewModel)
            .edgesIgnoringSafeArea(.all)
    }
}
