import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    var background = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupLogo()
        setupLetsStartButton()
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
    
    func setupLogo() {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo")  // Use the icon image provided
        logoImageView.contentMode = .scaleAspectFit
        
        view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(270)  // Adjust the top offset as needed
            make.width.equalTo(250)  // Adjust the width as needed
            make.height.equalTo(250)  // Adjust the height as needed
        }
    }
    
    private func setupLetsStartButton() {
        let letsStartButton = UIButton(type: .system)
        letsStartButton.setTitle("Let's Start", for: .normal)
        letsStartButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        letsStartButton.backgroundColor = UIColor(red: 0.988, green: 0.769, blue: 0.235, alpha: 1)
        letsStartButton.layer.cornerRadius = 20
        letsStartButton.setTitleColor(.white, for: .normal)
        
        // Adding shadow
        letsStartButton.layer.shadowColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1).cgColor
        letsStartButton.layer.shadowOpacity = 1
        letsStartButton.layer.shadowRadius = 4
        letsStartButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        letsStartButton.layer.shadowPath = UIBezierPath(roundedRect: letsStartButton.bounds, cornerRadius: 20).cgPath
        
        self.view.addSubview(letsStartButton)
        letsStartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            letsStartButton.widthAnchor.constraint(equalToConstant: 160),
            letsStartButton.heightAnchor.constraint(equalToConstant: 40),
            letsStartButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            letsStartButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 532)
        ])
        
        letsStartButton.addTarget(self, action: #selector(navigateToLogin), for: .touchUpInside)
    }
    
    @objc func navigateToLogin() {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
}


//    func testing() {
//        
//        NetworkManager.shared.GetTasks(childId:1) { result in
//            switch result {
//            case .success(let tokenResponse):
//                
//                print("Success \(tokenResponse.count)")
//                DispatchQueue.main.async {
//
//                    self.tasks = tokenResponse
//
//                }
//            case .failure(let error):
//                
//                print("Failed! \(error.localizedDescription)")
//                DispatchQueue.main.async {
//                }
//            }
//            
//        }
//        
//    }
    
