//
//  LoginViewController.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 18.01.26.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var tokenTextField: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    
    @objc func tap(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        alertLabel.isHidden = true
    }
    
    
    @IBAction func LoginAction(_ sender: Any) {
        
        let username = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let token = tokenTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        guard !token.isEmpty else {
            alertLabel.text = "Missing Token"
            alertLabel.isHidden = false
            return
        }
        
        loginButton.isEnabled = false
        
        Task { [weak self] in
            guard let self else { return }
            
            do {
                try await viewModel.signIn(username: username, token: token)
                loginButton.isEnabled = true
                alertLabel.text = "Login success"
                alertLabel.isHidden = false
            } catch {
                loginButton.isEnabled = true
                alertLabel.text = "Login Failed"
                alertLabel.isHidden = false
//                showAlert(title: "Login Failed", message: error.localizedDescription)
            }
        }
    }
}


extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
