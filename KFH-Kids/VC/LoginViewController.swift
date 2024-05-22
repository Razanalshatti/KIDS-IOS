//
//  LoginViewController.swift
//  KFH-Kids
//
//  Created by Aseel on 21/05/2024.
//

//import UIKit
//
//class LoginViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Set up the view background color
//        view.backgroundColor = .white
//        
//        // Set up any additional UI elements for the login screen
//        let label = UILabel()
//        label.text = "Login Page"
//        label.font = UIFont.systemFont(ofSize: 24)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(label)
//        
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//}
//

import UIKit

class LoginViewController: UIViewController {
    
    // UI elements
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
//    let passwordTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Password"
//        textField.isSecureTextEntry = true
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//    
//    let loginButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Login", for: .normal)
//        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
//        return button
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupUI()
//    }
    
//    func setupUI() {
//        view.addSubview(usernameTextField)
//        view.addSubview(passwordTextField)
//        view.addSubview(loginButton)
//        
//        // Setup constraints (assuming you're using AutoLayout)
//        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
//        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
//        loginButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
//            usernameTextField.widthAnchor.constraint(equalToConstant: 200),
//            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
//            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
//            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20)
//        ])
//    }
//    
//    @objc func loginButtonTapped() {
//        guard let username = usernameTextField.text, !username.isEmpty,
//              let password = passwordTextField.text, !password.isEmpty else {
//            // Show error alert if fields are empty
//            showAlert(message: "Please enter both username and password.")
//            return
//        }
//        
//        // Create a Child object (assuming id, parentId, points, baityAccountNumber, savingAccountingNumber, tasks, and request are not needed for login)
//        let child = Child(id: 0, username: username, password: password, parentId: 0, points: 0, baityAccountNumber: 0, savingAccountingNumber: 0, tasks: "", request: "")
//        
//        // Perform login
//        login(child: child)
//    }
//    
//    func login(child: Child) {
//        // Dummy URL, replace with your actual login endpoint
//        let loginURL = URL(string: "https://example.com/api/login")!
//        
//        var request = URLRequest(url: loginURL)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        do {
//            let jsonData = try JSONEncoder().encode(child)
//            request.httpBody = jsonData
//        } catch {
//            print("Failed to encode child: \(error)")
//            return
//        }
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Login request error: \(error)")
//                return
//            }
//            
//            guard let data = data else {
//                print("No data received")
//                return
//            }
//            
//            do {
//                let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
//                DispatchQueue.main.async {
//                    self.navigateToHome(token: tokenResponse.token)
//                }
//            } catch {
//                print("Failed to decode response: \(error)")
//            }
//        }.resume()
//    }
//    
//    func navigateToHome(token: String) {
//        let homeVC = HomeViewController()
//        homeVC.token = token
//        navigationController?.pushViewController(homeVC, animated: true)
//    }
//    
//    func showAlert(message: String) {
//        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
//    
//    @objc func navigateToHome() {
//        let homeViewController = HomeViewController()
//        navigationController?.pushViewController(loginViewController, animated: true)
//    }
}
