////
////  WelcomeViewController.swift
////  KFH-Kids
////
////  Created by Aseel on 21/05/2024.
////
//

//import UIKit
//
//class WelcomeViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Set up the main view background color
//        view.backgroundColor = .white
//
//        // First code
//        let view1 = UIView()
//        view1.frame = CGRect(x: 0, y: 0, width: 293, height: 236)
//        let image0 = UIImage(named: "5834.jpg")?.cgImage
//        let layer0 = CALayer()
//        layer0.contents = image0
//        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.17, b: 0, c: 0, d: 1, tx: -0.08, ty: 0))
//        layer0.bounds = view1.bounds
//        layer0.position = view1.center
//        view1.layer.addSublayer(layer0)
//        view.addSubview(view1)
//        view1.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            view1.widthAnchor.constraint(equalToConstant: 293),
//            view1.heightAnchor.constraint(equalToConstant: 236),
//            view1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
//            view1.topAnchor.constraint(equalTo: view.topAnchor, constant: 106)
//        ])
//
//        // Second code
//        let view2 = UIView()
//        view2.frame = CGRect(x: 0, y: 0, width: 375.48, height: 634)
//        view2.layer.borderWidth = 64
//        view2.layer.borderColor = UIColor(red: 0.971, green: 0.464, blue: 0.572, alpha: 1).cgColor
//        view.addSubview(view2)
//        view2.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            view2.widthAnchor.constraint(equalToConstant: 375.48),
//            view2.heightAnchor.constraint(equalToConstant: 634),
//            view2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -5.38),
//            view2.topAnchor.constraint(equalTo: view.topAnchor, constant: 17)
//        ])
//
//        // Third code
//        let view3 = UIView()
//        view3.frame = CGRect(x: 0, y: 0, width: 373.39, height: 663)
//        view3.layer.borderWidth = 58
//        view3.layer.borderColor = UIColor(red: 0.326, green: 0.783, blue: 0.756, alpha: 1).cgColor
//        view.addSubview(view3)
//        view3.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            view3.widthAnchor.constraint(equalToConstant: 373.39),
//            view3.heightAnchor.constraint(equalToConstant: 663),
//            view3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            view3.topAnchor.constraint(equalTo: view.topAnchor, constant: -2)
//        ])
//
//        // Fourth code
//        let view4 = UIView()
//        view4.frame = CGRect(x: 0, y: 0, width: 385.14, height: 665.83)
//        view4.layer.borderWidth = 58
//        view4.layer.borderColor = UIColor(red: 1, green: 0.797, blue: 0.488, alpha: 1).cgColor
//        view.addSubview(view4)
//        view4.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            view4.widthAnchor.constraint(equalToConstant: 385.14),
//            view4.heightAnchor.constraint(equalToConstant: 665.83),
//            view4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            view4.topAnchor.constraint(equalTo: view.topAnchor, constant: -7.83)
//        ])
//
//        // Fifth code
//        let label1 = UILabel()
//        label1.frame = CGRect(x: 0, y: 0, width: 275, height: 21)
//        label1.textColor = UIColor(red: 0.242, green: 0.242, blue: 0.242, alpha: 1)
//        label1.font = UIFont(name: "Nunito-Bold", size: 16)
//        // Line height: 21.82 pt
//        label1.textAlignment = .center
//        label1.text = "A milestone to reach your dream"
//        view.addSubview(label1)
//        label1.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            label1.widthAnchor.constraint(equalToConstant: 275),
//            label1.heightAnchor.constraint(equalToConstant: 21),
//            label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
//            label1.topAnchor.constraint(equalTo: view.topAnchor, constant: 346)
//        ])
//
//        // Sixth code (duplicated, so this will be omitted as it is identical to the Fifth code)
//
//        // Seventh code
//        let view7 = UIView()
//        view7.frame = CGRect(x: 0, y: 0, width: 153, height: 40)
//        let shadows = UIView()
//        shadows.frame = view7.frame
//        shadows.clipsToBounds = false
//        view7.addSubview(shadows)
//        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 50)
//        let layer7_0 = CALayer()
//        layer7_0.shadowPath = shadowPath0.cgPath
//        layer7_0.shadowColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1).cgColor
//        layer7_0.shadowOpacity = 1
//        layer7_0.shadowRadius = 4
//        layer7_0.shadowOffset = CGSize(width: 0, height: 4)
//        layer7_0.bounds = shadows.bounds
//        layer7_0.position = shadows.center
//        shadows.layer.addSublayer(layer7_0)
//        let shapes = UIView()
//        shapes.frame = view7.frame
//        shapes.clipsToBounds = true
//        view7.addSubview(shapes)
//        let layer7_1 = CALayer()
//        layer7_1.backgroundColor = UIColor(red: 1, green: 0.797, blue: 0.488, alpha: 1).cgColor
//        layer7_1.bounds = shapes.bounds
//        layer7_1.position = shapes.center
//        shapes.layer.addSublayer(layer7_1)
//        shapes.layer.cornerRadius = 50
//        view.addSubview(view7)
//        view7.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            view7.widthAnchor.constraint(equalToConstant: 153),
//            view7.heightAnchor.constraint(equalToConstant: 40),
//            view7.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105),
//            view7.topAnchor.constraint(equalTo: view.topAnchor, constant: 436)
//        ])
//
//        // Switch: Login label code replaced by "Let's Start" button code
//        let letsStartButton = UIButton(type: .system)
//        letsStartButton.setTitle("Let's Start", for: .normal)
//        letsStartButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
//        letsStartButton.translatesAutoresizingMaskIntoConstraints = false
//        letsStartButton.addTarget(self, action: #selector(navigateToLogin), for: .touchUpInside)
//        view.addSubview(letsStartButton)
//        NSLayoutConstraint.activate([
//            letsStartButton.widthAnchor.constraint(equalToConstant: 153),
//            letsStartButton.heightAnchor.constraint(equalToConstant: 40),
//            letsStartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105),
//            letsStartButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 436)
//        ])
//    }
//
//    @objc func navigateToLogin() {
//        let loginViewController = LoginViewController()
//        navigationController?.pushViewController(loginViewController, animated: true)
//    }
//}


//  WelcomeViewController.swift
//  KFH-Kids
//
//  Created by Aseel on 21/05/2024.
//

import UIKit
import SnapKit
class WelcomeViewController: UIViewController {
 var background = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupBackground()
        setupLetsStartButton()
        
        
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
    
    
    
    
    
    
    
    
}
