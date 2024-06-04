//
//  TransferPointsToMoneyViewController.swift
//  KFH-Kids
//
//  Created by Aseel on 02/06/2024.
//

//import UIKit
//import SnapKit
//
//protocol TransferPointsToMoneyDelegate: AnyObject {
//    func removeBlurEffect()
//}
//
//class TransferPointsToMoneyViewController: UIViewController {
//    
//    weak var delegate: TransferPointsToMoneyDelegate?
//
//    let backgroundImageView = UIImageView()
//    let moneyCardView = UIView()
//    let moneyLabel = UILabel()
//    let pointsLabel = UILabel()
//    let checkButton = UIButton()
//    let amountLabel = UILabel()
//    let increaseButton = UIButton(type: .system)
//    let decreaseButton = UIButton(type: .system)
//    let moneyImageView = UIImageView()
//    let moneyAmountLabel = UILabel()
//    
//    var moneyAmount = 1 {
//        didSet {
//            amountLabel.text = "\(moneyAmount) USD"
//            pointsLabel.text = "Cost: \(moneyAmount * 500) points"
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupSubviews()
//        setupConstraints()
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        print("Dismissed !!!!!")
//        delegate?.removeBlurEffect()
//    }
//    
//    func setupSubviews() {
//        // Background Image
//        backgroundImageView.image = UIImage(named: "moneybackground")
//        backgroundImageView.contentMode = .scaleAspectFill
//        view.addSubview(backgroundImageView)
//        
//        // Money Card Background
//        view.addSubview(moneyCardView)
//        
//        // Money Image View
//        moneyImageView.image = UIImage(named: "money")
//        moneyImageView.contentMode = .scaleAspectFit
//        moneyCardView.addSubview(moneyImageView)
//        
//        // Money Amount Label
//        moneyAmountLabel.text = "10"
//        moneyAmountLabel.font = UIFont.systemFont(ofSize: 16)
//        moneyCardView.addSubview(moneyAmountLabel)
//        
//        // Money Label
//        moneyLabel.text = "Money"
//        moneyLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        moneyLabel.textColor = .black
//        moneyCardView.addSubview(moneyLabel)
//        
//        // Points Label
//        pointsLabel.text = "Cost: 500 points"
//        pointsLabel.font = UIFont.systemFont(ofSize: 16)
//        pointsLabel.textColor = .black
//        moneyCardView.addSubview(pointsLabel)
//        
//        // Amount Label
//        amountLabel.text = "\(moneyAmount) USD"
//        amountLabel.font = UIFont.systemFont(ofSize: 16)
//        amountLabel.textColor = .black
//        amountLabel.textAlignment = .center
//        moneyCardView.addSubview(amountLabel)
//        
//        // Increase Button
//        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
//        let increaseImage = UIImage(systemName: "plus.circle.fill", withConfiguration: symbolConfig)
//        increaseButton.setImage(increaseImage, for: .normal)
//        increaseButton.tintColor = .white
//        increaseButton.addTarget(self, action: #selector(increaseButtonTapped), for: .touchUpInside)
//        moneyCardView.addSubview(increaseButton)
//        
//        // Decrease Button
//        let decreaseImage = UIImage(systemName: "minus.circle.fill", withConfiguration: symbolConfig)
//        decreaseButton.setImage(decreaseImage, for: .normal)
//        decreaseButton.tintColor = .white
//        decreaseButton.addTarget(self, action: #selector(decreaseButtonTapped), for: .touchUpInside)
//        moneyCardView.addSubview(decreaseButton)
//        
//        // Check Button
//        let checkImage = UIImage(named: "checkmark")
//        checkButton.setImage(checkImage, for: .normal)
//        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
//        moneyCardView.addSubview(checkButton)
//    }
//    
//    func setupConstraints() {
//        // Money Card View Constraints
//        moneyCardView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(550)
//        }
//        
//        // Background Image Constraints
//        backgroundImageView.snp.makeConstraints { make in
//            make.leading.trailing.bottom.top.equalTo(moneyCardView)
//        }
//        
//        // Other subview constraints
//        moneyImageView.snp.makeConstraints { make in
//            make.top.equalTo(moneyCardView).offset(50)
//            make.centerX.equalTo(moneyCardView)
//            make.width.equalTo(100)
//            make.height.equalTo(100)
//        }
//        
//        moneyAmountLabel.snp.makeConstraints { make in
//            make.top.equalTo(moneyImageView.snp.bottom).offset(5)
//            make.centerX.equalTo(moneyCardView)
//        }
//        
//        moneyLabel.snp.makeConstraints { make in
//            make.top.equalTo(moneyAmountLabel.snp.bottom).offset(20)
//            make.centerX.equalTo(moneyCardView)
//        }
//        
//        amountLabel.snp.makeConstraints { make in
//            make.top.equalTo(moneyLabel.snp.bottom).offset(20)
//            make.centerX.equalTo(moneyCardView)
//        }
//        
//        increaseButton.snp.makeConstraints { make in
//            make.centerY.equalTo(amountLabel)
//            make.left.equalTo(amountLabel.snp.right).offset(10)
//        }
//        
//        decreaseButton.snp.makeConstraints { make in
//            make.centerY.equalTo(amountLabel)
//            make.right.equalTo(amountLabel.snp.left).offset(-10)
//        }
//        
//        pointsLabel.snp.makeConstraints { make in
//            make.top.equalTo(amountLabel.snp.bottom).offset(10)
//            make.centerX.equalTo(moneyCardView)
//        }
//        
//        checkButton.snp.makeConstraints { make in
//            make.top.equalTo(pointsLabel.snp.bottom).offset(20)
//            make.centerX.equalTo(moneyCardView)
//            make.width.height.equalTo(40)
//        }
//    }
//    
//    @objc func increaseButtonTapped() {
//        moneyAmount += 1
//    }
//    
//    @objc func decreaseButtonTapped() {
//        if moneyAmount > 1 {
//            moneyAmount -= 1
//        }
//    }
//    
//    @objc func checkButtonTapped() {
//        delegate?.removeBlurEffect()
//        dismiss(animated: true, completion: nil)
//    }
//}
//
//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//struct TransferPointsToMoneyViewControllerPreview: PreviewProvider {
//    static var previews: some View {
//        GenericViewControllerRepresentable(TransferPointsToMoneyViewController())
//    }
//}
//
//struct GenericViewControllerRepresentable<ViewController: UIViewController>: UIViewControllerRepresentable {
//    
//    let viewController: ViewController
//    
//    init(_ builder: @autoclosure @escaping () -> ViewController) {
//        self.viewController = builder()
//    }
//    
//    func makeUIViewController(context: Context) -> ViewController {
//        viewController
//    }
//    
//    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
//    }
//}
//#endif
