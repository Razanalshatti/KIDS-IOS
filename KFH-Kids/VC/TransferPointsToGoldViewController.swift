

import UIKit
import SnapKit

protocol TransferPointsToGoldDelegate: AnyObject {
    func removeBlurEffect()
}

class TransferPointsToGoldViewController: UIViewController {
    
    weak var delegate: TransferPointsToGoldDelegate?

    let goldLabel = UILabel()
    let pointsLabel = UILabel()
    let checkButton = UIButton(type: .system)
    let amountLabel = UILabel()
    let increaseButton = UIButton(type: .system)
    let decreaseButton = UIButton(type: .system)
    let coinIcon = UIImageView()
    let coinLabel = UILabel()

    var goldAmount = 1 {
        didSet {
            amountLabel.text = "\(goldAmount) GM"
            pointsLabel.text = "Cost: \(goldAmount * 550) points"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemYellow

        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {
        // Coin Icon and Label
        coinIcon.image = UIImage(systemName: "star.circle")
        coinIcon.tintColor = .yellow
        view.addSubview(coinIcon)

        coinLabel.text = "10"
        coinLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(coinLabel)

        // Gold Label
        goldLabel.text = "Gold"
        goldLabel.font = UIFont.boldSystemFont(ofSize: 18)
        goldLabel.textColor = .black
        view.addSubview(goldLabel)

        // Points Label
        pointsLabel.text = "Cost: 550 points"
        pointsLabel.font = UIFont.systemFont(ofSize: 16)
        pointsLabel.textColor = .black
        view.addSubview(pointsLabel)

        // Amount Label
        amountLabel.text = "\(goldAmount) GM"
        amountLabel.font = UIFont.systemFont(ofSize: 16)
        amountLabel.textColor = .black
        amountLabel.textAlignment = .center
        view.addSubview(amountLabel)

        // Increase Button
        // SF Symbols
           let symbolConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
           let symbolImage = UIImage(systemName: "plus.circle.fill", withConfiguration: symbolConfig)
        increaseButton.setImage(symbolImage, for: .normal)
        increaseButton.tintColor = .white
//        increaseButton.setTitle("+", for: .normal)
//        increaseButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        increaseButton.addTarget(self, action: #selector(increaseButtonTapped), for: .touchUpInside)
        view.addSubview(increaseButton)

        // Decrease Button
        decreaseButton.setTitle("-", for: .normal)
        decreaseButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        decreaseButton.addTarget(self, action: #selector(decreaseButtonTapped), for: .touchUpInside)
        view.addSubview(decreaseButton)

        // Check Button
        checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        checkButton.tintColor = .green
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        view.addSubview(checkButton)
    }

    @objc func increaseButtonTapped() {
        goldAmount += 1
    }

    @objc func decreaseButtonTapped() {
        if goldAmount > 1 {
            goldAmount -= 1
        }
    }

    @objc func checkButtonTapped() {
        delegate?.removeBlurEffect()
        dismiss(animated: true, completion: nil)
    }

    func setupConstraints() {
        coinIcon.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view)
        }

        coinLabel.snp.makeConstraints { make in
            make.top.equalTo(coinIcon.snp.bottom).offset(5)
            make.centerX.equalTo(view)
        }

        goldLabel.snp.makeConstraints { make in
            make.top.equalTo(coinLabel.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }

        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(goldLabel.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }

        increaseButton.snp.makeConstraints { make in
            make.centerY.equalTo(amountLabel)
            make.left.equalTo(amountLabel.snp.right).offset(10)
        }

        decreaseButton.snp.makeConstraints { make in
            make.centerY.equalTo(amountLabel)
            make.right.equalTo(amountLabel.snp.left).offset(-10)
        }

        pointsLabel.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(10)
            make.centerX.equalTo(view)
        }

        checkButton.snp.makeConstraints { make in
            make.top.equalTo(pointsLabel.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.height.equalTo(40)
        }
    }
}
