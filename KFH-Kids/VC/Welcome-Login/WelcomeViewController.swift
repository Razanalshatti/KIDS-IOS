
import UIKit
import SnapKit
class WelcomeViewController: UIViewController {
 var background = UIImageView()
    
    
    var tasks = [MyTask]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()
        setupLetsStartButton()
        
        fetchTasks(childId: 1)
        
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
    
    
   

    private func setupLetsStartButton() {
        let letsStartButton = UIButton(type: .system)
        letsStartButton.setTitle("Let's Start", for: .normal)
        letsStartButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        letsStartButton.backgroundColor = UIColor(red: 1, green: 0.797, blue: 0.488, alpha: 1)
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
            letsStartButton.widthAnchor.constraint(equalToConstant: 153),
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
//    
    func fetchTasks(childId: Int) {
        NetworkManager.shared.GetTasks(childId: childId) { result in
            switch result {
            case .success(let tasks):
                DispatchQueue.main.async {
                    self.tasks = tasks
                   
                }
            case .failure(let error):
                print("Failed to fetch tasks: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    
}
