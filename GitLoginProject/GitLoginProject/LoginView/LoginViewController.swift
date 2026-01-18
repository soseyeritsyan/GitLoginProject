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
    @IBOutlet weak var passwordTextField: UITextField!
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
        viewModel.username = emailTextField.text
        viewModel.password = passwordTextField.text
        
        if viewModel.isValid {
            alertLabel.isHidden = true
        } else {
            alertLabel.isHidden = false
        }
    }
}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
