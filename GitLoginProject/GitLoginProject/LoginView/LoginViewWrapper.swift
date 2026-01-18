//
//  LoginViewWrapper.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 16.01.26.
//

import SwiftUI

struct LoginViewWrapper: UIViewControllerRepresentable {
    let viewModel: LoginViewModel
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    
    
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(
            name: "LoginStoryboard",
            bundle: .main
        )
        
        guard let vc = storyboard.instantiateViewController(
            withIdentifier: "LoginVC"
        ) as? LoginViewController else {
            fatalError("LoginVC not found")
        }
        
        vc.viewModel = viewModel
        return vc
    }
}
