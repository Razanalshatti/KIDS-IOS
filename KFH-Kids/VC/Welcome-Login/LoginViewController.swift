

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    var background = UIImageView()
    var usernameTextField = UITextField()
    var passwordTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupLoginLabel()
        setupUsernameTextField()
        setupPasswordTextField()
        setupLoginButton()
    }

    func setupBackground() {
        background = UIImageView()
        background.image = UIImage(named: "welcome")
        background.contentMode = .scaleAspectFill
        background.clipsToBounds = true

        view.addSubview(background)

        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupLoginLabel() {
        let loginLabel = UILabel()
        loginLabel.text = "Login"
        loginLabel.textColor = UIColor(red: 1.0, green: 0.796, blue: 0.486, alpha: 1.0)
        loginLabel.font = UIFont.boldSystemFont(ofSize: 39)
        
        self.view.addSubview(loginLabel)
        
        loginLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.view).offset(150)
            make.top.equalTo(self.view).offset(190)
        }
    }

    private func setupUsernameTextField() {
        usernameTextField.placeholder = "Username"
        usernameTextField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        usernameTextField.layer.cornerRadius = 20
        usernameTextField.text = "Razan"
        usernameTextField.setLeftPaddingPoints(10)
        
        self.view.addSubview(usernameTextField)
        
        usernameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(308)
            make.width.equalTo(295)
            make.height.equalTo(40)
        }
    }

    private func setupPasswordTextField() {
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.isSecureTextEntry = true
        passwordTextField.text = "1234"
        passwordTextField.setLeftPaddingPoints(10)
        
        self.view.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(usernameTextField.snp.bottom).offset(50)
            make.width.equalTo(295)
            make.height.equalTo(40)
        }
    }

    private func setupLoginButton() {
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Let's Go", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        loginButton.backgroundColor = UIColor(red: 1, green: 0.797, blue: 0.488, alpha: 1)
        loginButton.layer.cornerRadius = 20
        loginButton.setTitleColor(.white, for: .normal)

        loginButton.layer.shadowColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1).cgColor
        loginButton.layer.shadowOpacity = 1
        loginButton.layer.shadowRadius = 4
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        loginButton.layer.shadowPath = UIBezierPath(roundedRect: loginButton.bounds, cornerRadius: 20).cgPath
        
        self.view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.width.equalTo(153)
            make.height.equalTo(40)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(532)
        }
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }

    @objc func loginButtonTapped() {
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        if username?.isEmpty ?? true || password?.isEmpty ?? true {
            let message = """
            Please enter the required:
            \(username?.isEmpty ?? true ? "Username" : "")
            \(password?.isEmpty ?? true ? "Password" : "")
            """
            presentAlertWithTitle(title: "Error", message: message)
            return
        }
        
        let child = Child(Id: 1, Username: username!, Password: password!, ParentId: 1, Points: 5, BaitiAccountNumber: 54, SavingsAccountNumber: 6789, Balance: 129, Tasks: [], request: username!)
        
        NetworkManager.shared.login(child: child) { [weak self] result in
            switch result {
            case .success(let tokenResponse):
                DispatchQueue.main.async {
                    let homeViewController = HomeTableViewController()
                    homeViewController.child = tokenResponse
                    self?.navigationController?.pushViewController(homeViewController, animated: true)
                }
            case .failure(_):
                DispatchQueue.main.async {
    
                    self?.presentAlertWithTitle(title: "Error", message: "Username or password is incorrect")
                }
            }
        }
    }
    

    func presentAlertWithTitle(title: String, message: String, completion: (() -> Void)? = nil) {
        _ = UIAlertController(title: title, message: message, preferredStyle: .alert)
        _ = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
    }

}

extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

 
