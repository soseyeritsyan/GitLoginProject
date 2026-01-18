//
//  LoginView.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 08.01.26.
//

import SwiftUI
import SwiftData

struct LoginView: View {

    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        VStack {
            LoginViewWrapper(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
        }
    }
}


#Preview {
    LoginView()
}
