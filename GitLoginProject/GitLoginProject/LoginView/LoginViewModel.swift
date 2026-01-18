//
//  LoginViewModel.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 18.01.26.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var username: String?
    @Published var password: String?
    
    var isValid: Bool {
        guard let username, let password else { return false }
        return !username.isEmpty && !password.isEmpty
    }
}
