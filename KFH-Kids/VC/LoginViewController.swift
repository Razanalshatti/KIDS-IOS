//
//  LoginViewController.swift
//  KFH-Kids
//
//  Created by Aseel on 21/05/2024.


import UIKit

class LoginViewController: UIViewController {

    var usernameTextField = UITextField()
    var passwordTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupLoginLabel()
        setupUsernameTextField()
        setupPasswordTextField()
        setupLoginButton()
    }
    
    private func setupLoginLabel() {
        let loginLabel = UILabel()
        loginLabel.text = "Login"
        loginLabel.frame = CGRect(x: 0, y: 0, width: 233, height: 21)
        loginLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.87)
        loginLabel.font = UIFont(name: "Nunito-Bold", size: 34)
        
        self.view.addSubview(loginLabel)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginLabel.widthAnchor.constraint(equalToConstant: 233),
            loginLabel.heightAnchor.constraint(equalToConstant: 46.38),
            loginLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            loginLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 115)
        ])
    }
    
    private func setupUsernameTextField() {
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(usernameTextField)
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            usernameTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
            usernameTextField.widthAnchor.constraint(equalToConstant: 250),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupPasswordTextField() {
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 250),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupLoginButton() {
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        loginButton.backgroundColor = UIColor(red: 1, green: 0.797, blue: 0.488, alpha: 1)
        loginButton.layer.cornerRadius = 20
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.addTarget(self, action: #selector(navigateToHome), for: .touchUpInside)
        
        self.view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.widthAnchor.constraint(equalToConstant: 153),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30)
        ])
    }
    
    @objc func navigateToHome() {
        guard let username = usernameTextField.text, !username.isEmpty else {
            presentAlertWithTitle(title: "Error", message: "Username is required")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            presentAlertWithTitle(title: "Error", message: "Password is required")
            return
        }
        
        let homeViewController = HomeViewController()
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
