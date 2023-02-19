//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/9/21.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username..."
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.backgroundColor = .secondarySystemBackground
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        field.layer.cornerRadius = 8.0
        field.layer.masksToBounds = true
        field.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        field.layer.borderWidth = 1.0
        field.returnKeyType = .next
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address..."
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.backgroundColor = .secondarySystemBackground
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        field.layer.cornerRadius = 8.0
        field.layer.masksToBounds = true
        field.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        field.layer.borderWidth = 1.0
        field.returnKeyType = .next
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password..."
        field.isSecureTextEntry = true
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.backgroundColor = .secondarySystemBackground
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        field.layer.cornerRadius = 8.0
        field.layer.masksToBounds = true
        field.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        field.layer.borderWidth = 1.0
        field.returnKeyType = .continue
        return field
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8.0
        button.layer.masksToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        view.backgroundColor = .systemBackground
    }
    
    private func addSubViews() {
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(createAccountButton)
    }
    
    override func viewDidLayoutSubviews() {
        usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.bottom + 40, width: view.width - 40, height: 52)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom + 20, width: view.width - 40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 20, width: view.width - 40, height: 52)
        createAccountButton.frame = CGRect(x: 20, y: passwordField.bottom + 40, width: view.width - 40, height: 52)
    }
    
    @objc func didTapCreateAccountButton() {
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let username = usernameField.text, !username.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else { return }
        
        AuthManager.shared.registerUser(username: username, email: email, password: password) { registered in
            DispatchQueue.main.async {
                if registered {
                    // New user registered successfully
                    // Sign in
                    print("User registered successfully, signing you in..")
                } else {
                    // Error creating account
                    let alert = UIAlertController(title: "Account creation Failed", message: "We can't create account. Check Username/Email and password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            didTapCreateAccountButton()
        }
        return true
    }
}
