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
    
    func setupBackground(){
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
//        loginLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.87)
        loginLabel.textColor = UIColor(red: 1.0, green: 0.796, blue: 0.486, alpha: 1.0)
        loginLabel.font = UIFont.boldSystemFont(ofSize: 39)
        
        self.view.addSubview(loginLabel)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 150),
            loginLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 190)
        ])
    }
    
    private func setupUsernameTextField() {
        usernameTextField.placeholder = "Username"
        usernameTextField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        usernameTextField.layer.cornerRadius = 20
        usernameTextField.setLeftPaddingPoints(10)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(usernameTextField)
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            usernameTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 308),
            usernameTextField.widthAnchor.constraint(equalToConstant: 295),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupPasswordTextField() {
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.isSecureTextEntry = true
        passwordTextField.setLeftPaddingPoints(10)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 50),
            passwordTextField.widthAnchor.constraint(equalToConstant: 295),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
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
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.widthAnchor.constraint(equalToConstant: 153),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 532)
        ])
        
        loginButton.addTarget(self, action: #selector(navigateToHome), for: .touchUpInside)
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

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}




    
  
