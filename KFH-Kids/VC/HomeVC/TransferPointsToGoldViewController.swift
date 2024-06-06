import UIKit
import SnapKit

protocol TransferPointsToGoldDelegate: AnyObject {
    func removeBlurEffect()
    
}

class TransferPointsToGoldViewController: UIViewController {
    
    weak var delegate: TransferPointsToGoldDelegate?
    
    let backgroundImageView = UIImageView()
    let goldCardView = UIView()
    let pointsLabel = UILabel()
    let checkButton = UIButton()
    let amountLabel = UILabel()
    let increaseButton = UIButton(type: .system)
    let decreaseButton = UIButton(type: .system)
    let coinImageView = UIImageView()
    let coinLabel = UILabel()
    let containerView = UIView()
    
    var child: TokenResponse?

    var goldAmount = 1 {
        didSet {
            updateCoinLabel()
//            amountLabel.text = "\(goldAmount) GM"
//            pointsLabel.text = "Cost: \(goldAmount * 550) points"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        updateCoinLabel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.removeBlurEffect()
        
    }
    
    func setupSubviews() {
        // Background Image
        backgroundImageView.image = UIImage(named: "goldbackground")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        
        let favouritesImageView = UIImageView(image: UIImage(named: "favourites"))
        favouritesImageView.contentMode = .scaleAspectFill
        goldCardView.addSubview(favouritesImageView)
        
        // Gold Card Background
        view.addSubview(goldCardView)
        
        // Coin Image View
        coinImageView.image = UIImage(named: "gold")
        coinImageView.contentMode = .scaleAspectFit
        goldCardView.addSubview(coinImageView)
        
        // Coin Label
        coinLabel.font = UIFont.boldSystemFont(ofSize: 22)
        coinLabel.textColor = .black
        goldCardView.addSubview(coinLabel)
        
        // Points Label
        pointsLabel.text = "Cost: 550 points"
        pointsLabel.font = UIFont.systemFont(ofSize: 16)
        pointsLabel.textColor = .black
        goldCardView.addSubview(pointsLabel)
        
        // Amount Container View
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 25
        containerView.layer.masksToBounds = true
        goldCardView.addSubview(containerView)
        
        // Amount Label
        amountLabel.font = UIFont.systemFont(ofSize: 16)
        amountLabel.textColor = .black
        amountLabel.textAlignment = .center
        containerView.addSubview(amountLabel)
        
        // Increase Button
        increaseButton.setTitle("+", for: .normal)
        increaseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        increaseButton.setTitleColor(.black, for: .normal)
        increaseButton.addTarget(self, action: #selector(increaseButtonTapped), for: .touchUpInside)
        containerView.addSubview(increaseButton)
        
        // Decrease Button
        decreaseButton.setTitle("-", for: .normal)
        increaseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        increaseButton.setTitleColor(.black, for: .normal)
        decreaseButton.addTarget(self, action: #selector(decreaseButtonTapped), for: .touchUpInside)
        containerView.addSubview(decreaseButton)
        
        let imageSize: CGFloat = 24
        favouritesImageView.snp.makeConstraints { make in
            make.centerY.equalTo(coinLabel)
            make.leading.equalTo(coinLabel.snp.trailing).offset(5)
            make.width.height.equalTo(30)
        }
        
        // Check Button
        let checkImage = UIImage(named: "checkmark")
        checkButton.setImage(checkImage, for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        goldCardView.addSubview(checkButton)
    }
    
    func setupConstraints() {
        // Gold Card View Constraints
        goldCardView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(550)
        }
        
        // Background Image Constraints
        backgroundImageView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalTo(goldCardView)
        }
        
        // Other subview constraints
        coinImageView.snp.makeConstraints { make in
            make.top.equalTo(goldCardView).offset(85)
            make.centerX.equalTo(goldCardView)
            make.width.equalTo(250)
            make.height.equalTo(230)
        }
        
        coinLabel.snp.makeConstraints { make in
            make.top.equalTo(goldCardView).offset(25)
            make.right.equalTo(goldCardView).offset(-50)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(coinImageView.snp.bottom).offset(-40)
            make.centerX.equalTo(goldCardView)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        
        decreaseButton.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.left.equalTo(containerView).offset(10)
            make.width.height.equalTo(30) 
        }
        
        amountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.centerX.equalTo(containerView)
        }
        
//        pointsLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(containerView)
//            make.left.equalTo(containerView).offset(10)
//        }
        
        increaseButton.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.right.equalTo(containerView).offset(-10)
            make.width.height.equalTo(30)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(20)
            make.centerX.equalTo(goldCardView)
            make.width.height.equalTo(70)
        }
    }
    
    @objc func increaseButtonTapped() {
        goldAmount += 1
    }
    
    @objc func decreaseButtonTapped() {
        if (goldAmount > 1) {
            goldAmount -= 1
        }
    }
    
    @objc func checkButtonTapped() {
        goldRequest()
    }
    func updateCoinLabel(){
        let coinText = "\(goldAmount) GM"
        let pointsText = "   =    \(goldAmount * 550) Points"
        let fullText = "\(coinText)  \(pointsText)"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let coinRange = (fullText as NSString).range(of: coinText)
        let pointsRange = (fullText as NSString).range(of: pointsText)
        
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 18), range: coinRange)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 18), range: pointsRange)
        
        amountLabel.attributedText = attributedString
    }

    func goldRequest(){
        
        var convertGoldToPoints = goldAmount * 550
                
        
        if child?.points ?? 0 < 550 {
            let message = "NOT ENOUGH POINTS"
            presentAlertWithTitle(title: "Error", message: message)
        } else {
            NetworkManager.shared.transfer(parentId: child?.parentId ?? 0, childId: child?.childId ?? 0, transferPoints: convertGoldToPoints) { result in
                
                DispatchQueue.main.async {
                    switch result{
                    case .success(let transfer):
                        print("success \(transfer)")
                      
                        let message = "REQUEST SENT SUCCESSFULLY"
                        self.presentAlertWithTitle(title: "Success", message: message)
                                      case .failure(let error):
                                      print("failure \(error)")
                        self.delegate?.removeBlurEffect()
                        self.dismiss(animated: true, completion: nil)
                    }
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

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ExampleViewControllerPreview: PreviewProvider {
    static var previews: some View {
        GenericViewControllerRepresentable(TransferPointsToGoldViewController())
    }
}

struct GenericViewControllerRepresentable<ViewController: UIViewController>: UIViewControllerRepresentable {
    
    let viewController: ViewController
    
    init(_ builder: @autoclosure @escaping () -> ViewController) {
        self.viewController = builder()
    }
    
    func makeUIViewController(context: Context) -> ViewController {
        viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
}
#endif
