//
//  LoginViewWrapper.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 16.01.26.
//

import SwiftUI

struct LoginViewWrapper: UIViewControllerRepresentable {
    let viewModel: LoginViewModel?

    func makeUIViewController(context: Context) -> LoginViewController {
        let storyboard = UIStoryboard(
            name: "LoginStoryboard",
            bundle: .main
        )
        
        guard let vc = storyboard.instantiateViewController(
            withIdentifier: "LoginVC") as? LoginViewController else {
            fatalError("LoginVC not found")
        }
        
        vc.viewModel = viewModel
                
        return vc
    }

    func updateUIViewController(
        _ uiViewController: LoginViewController,
        context: Context
    ) {}
}

