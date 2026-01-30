//
//  LoginView.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 08.01.26.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel: LoginViewModel

    init(authState: AuthenticationState) {
        _viewModel = StateObject(
            wrappedValue: LoginViewModel(authState: authState)
        )
    }

    var body: some View {
        LoginViewWrapper(viewModel: viewModel)
            .edgesIgnoringSafeArea(.all)
    }
}
