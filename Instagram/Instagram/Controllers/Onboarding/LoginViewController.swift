//
//  LoginViewController.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/9/21.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    private let usernameEmailTextField: UITextField =  {
        let field = UITextField()
        field.placeholder = "Username or Email..."
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8.0
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        field.returnKeyType = .next
        return field
    }()
    
    private let passwordTextField: UITextField =  {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8.0
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        field.returnKeyType = .continue
        return field
    }()
    
    private let loginButton: UIButton =  {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8.0
        return button
    }()
    
    private let createAccountButton: UIButton =  {
        let button = UIButton()
        button.setTitle("New User? Create Account", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8.0
        return button
    }()
    
    private let termsButton: UIButton =  {
        let button = UIButton()
        button.setTitle("Terms & Conditions", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton =  {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    @objc func didTapLoginButton() {
        usernameEmailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        guard let usernameEmail = usernameEmailTextField.text, !usernameEmail.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, password.count >= 8  else {
            // Show error message
            return
        }
        var email: String?
        var userName: String?
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            email = usernameEmail
        } else {
            userName = usernameEmail
        }
        
        AuthManager.shared.loginUser(username: userName, email: email, password: password) { (success) in
            DispatchQueue.main.async {
                if success {
                    // Successful login
                    self.dismiss(animated: true, completion: nil)
                } else {
                    // Error loggin in
                    let alert = UIAlertController(title: "Log In Failed", message: "We can't log you in. Check Username/Email and password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
 
    }
    
    @objc func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        let navigationController = UINavigationController(rootViewController: vc)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func didTapTermsButton() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else { return }
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true, completion: nil)
    }
    
    @objc func didTapPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else { return }
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        view.backgroundColor = .systemBackground
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        
        usernameEmailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func addSubViews() {
        print("adding subviews")
        view.addSubview(headerView)
        view.addSubview(usernameEmailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)

    }
    
    private func configureHeaderView() {
        print("configuring headerview")
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        backgroundImageView.frame = headerView.bounds
        headerView.addSubview(backgroundImageView)
        
        let logo = UIImageView(image: UIImage(named: "logo"))
        logo.backgroundColor = .none
        logo.contentMode = .scaleAspectFit
        logo.frame = CGRect(x: 50, y: headerView.frame.size.height/5.0 + view.safeAreaInsets.bottom, width: headerView.frame.size.width - 100, height: headerView.frame.size.height/2.5)
        headerView.addSubview(logo)
    }
    
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x: 0, y: view.frame.origin.y, width: view.frame.size.width, height: view.frame.height/3.0)
        configureHeaderView()
       
        usernameEmailTextField.frame = CGRect(x: 20, y: headerView.bottom + 40, width: view.width - 40, height: 50)
        passwordTextField.frame = CGRect(x: 20, y: usernameEmailTextField.bottom + 20, width: view.width - 40, height: 50)
        loginButton.frame = CGRect(x: 20, y: passwordTextField.bottom + 30, width: view.width - 40, height: 50)
        createAccountButton.frame = CGRect(x: 20, y: loginButton.bottom + 20, width: view.width - 40, height: 50)
        
        termsButton.frame = CGRect(x: 20, y: view.bottom - view.safeAreaInsets.bottom - 100, width: view.width - 40, height: 50)
        privacyButton.frame = CGRect(x: 20, y: view.bottom - view.safeAreaInsets.bottom - 50, width: view.width - 40, height: 50)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
