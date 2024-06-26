//import UIKit
//import SnapKit
//
//class BankCardViewController: UIViewController {
//    
//    let bankCardImageView = UIImageView()
//    let amountTextField = UITextField()
//    let saveButton = UIButton(type: .system)
//    var background = UIImageView()
//    
//    var balance: Decimal?
//    var childId: Int?
//    var balanceLabel: UILabel?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupBackground()
//        setupBankCardImageView()
//        setupBalanceLabel()
//        setupAmountTextField()
//        setupSaveButton()
//        setupConstraints()
//        fetchBalance(childId: childId ?? 2)
//    }
//    
//    func setupBackground() {
//        background.image = UIImage(named: "savingbackground")
//        background.contentMode = .scaleAspectFill
//        background.clipsToBounds = true
//        view.addSubview(background)
//        background.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
//    
//    func setupBankCardImageView() {
//        bankCardImageView.image = UIImage(named: "saving")
//        bankCardImageView.contentMode = .scaleAspectFit
//        view.addSubview(bankCardImageView)
//    }
//    
//    private func setupBalanceLabel() {
//        balanceLabel = UILabel()
//        balanceLabel?.text = "💰 Balance : \(balance ?? 0) KWD"
//        balanceLabel?.textColor = .black
//        balanceLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//        balanceLabel?.textAlignment = .center
//        view.addSubview(balanceLabel!)
//    }
//    
//    func setupAmountTextField() {
//        amountTextField.placeholder = "Enter amount to be saved"
//        amountTextField.layer.cornerRadius = 20
//        amountTextField.borderStyle = .roundedRect
//        amountTextField.keyboardType = .decimalPad
//        amountTextField.textAlignment = .center
//        view.addSubview(amountTextField)
//    }
//    
//    func setupSaveButton() {
//        saveButton.setTitle("Save", for: .normal)
//        saveButton.backgroundColor = UIColor.systemYellow
//        saveButton.layer.cornerRadius = 20
//        saveButton.setTitleColor(.white, for: .normal)
//        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
//        view.addSubview(saveButton)
//    }
//    
//    func setupConstraints() {
//        bankCardImageView.snp.makeConstraints { make in
//            make.centerX.equalTo(view)
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
//            make.width.equalTo(view).multipliedBy(0.8)
//            make.height.equalTo(bankCardImageView.snp.width).multipliedBy(0.6)
//        }
//        
//        balanceLabel?.snp.makeConstraints { make in
//            make.top.equalTo(bankCardImageView.snp.bottom).offset(20)
//            make.centerX.equalTo(view)
//        }
//        
//        amountTextField.snp.makeConstraints { make in
//            make.top.equalTo(balanceLabel!.snp.bottom).offset(20)
//            make.centerX.equalTo(view)
//            make.width.equalTo(view).multipliedBy(0.8)
//            make.height.equalTo(40)
//        }
//        
//        saveButton.snp.makeConstraints { make in
//            make.top.equalTo(amountTextField.snp.bottom).offset(20)
//            make.centerX.equalTo(view)
//            make.width.equalTo(amountTextField)
//            make.height.equalTo(50)
//        }
//    }
//    
//    @objc func saveButtonTapped() {
//        guard let amountText = amountTextField.text, !amountText.isEmpty, let amount = Double(amountText) else {
//            let alert = UIAlertController(title: "Error", message: "Please enter a valid amount", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            present(alert, animated: true, completion: nil)
//            return
//        }
//        
//        print("Saved \(amount) to savings account")
//        
//        transferMoney(childId: childId ?? 0, money: Int(amount))
//        
//    
//        amountTextField.text = ""
//    }
//    
//    func fetchBalance(childId: Int) {
//        NetworkManager.shared.getBalance(childId: childId) { result in
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    self.balance = data.balance
//                    self.balanceLabel?.text = "💰 Balance: \(self.balance ?? 0) KWD"
//                }
//            case .failure(let error):
//                print("Failed to fetch balance: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    func transferMoney(childId: Int,money:Int) {
//        NetworkManager.shared.transferMoney(childId: childId,transferMoney: money) { result in
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//
//                    let alert = UIAlertController(title: "Success", message: "Amount saved successfully", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
//                        self.navigationController?.popViewController(animated: true)
//                    }))
//                    self.present(alert, animated: true, completion: nil)
//                    print("Success!")
//                }
//            case .failure(let error):
//                print("Failed to fetch balance: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    
//}
import UIKit
import SnapKit

class BankCardViewController: UIViewController {
    
    let bankCardImageView = UIImageView()
    let amountTextField = UITextField()
    let saveButton = UIButton(type: .system)
    var background = UIImageView()
    
    var balance: Decimal?
    var childId: Int?
    var balanceLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupBankCardImageView()
        setupBalanceLabel()
        setupAmountTextField()
        setupSaveButton()
        setupConstraints()
        fetchBalance(childId: childId ?? 2)
    }
    
    func setupBackground() {
        background.image = UIImage(named: "savingbackground")
        background.contentMode = .scaleAspectFill
        background.clipsToBounds = true
        view.addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupBankCardImageView() {
        bankCardImageView.image = UIImage(named: "saving")
        bankCardImageView.contentMode = .scaleAspectFit
        view.addSubview(bankCardImageView)
    }
    
    private func setupBalanceLabel() {
        balanceLabel = UILabel()
        balanceLabel?.text = "💰 Balance : \(balance ?? 0) KWD"
        balanceLabel?.textColor = .black
        balanceLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        balanceLabel?.textAlignment = .center
        view.addSubview(balanceLabel!)
    }
    
    func setupAmountTextField() {
        amountTextField.placeholder = "Enter amount to be saved"
        amountTextField.layer.cornerRadius = 20
        amountTextField.layer.masksToBounds = true
        amountTextField.borderStyle = .none
        amountTextField.backgroundColor = UIColor.systemGray5 // Light gray background
        amountTextField.textColor = .black
        amountTextField.font = UIFont.systemFont(ofSize: 18) // Match the font style
        amountTextField.keyboardType = .decimalPad
        amountTextField.textAlignment = .center
        view.addSubview(amountTextField)
    }
    
    func setupSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = UIColor.systemYellow
        saveButton.layer.cornerRadius = 20
        saveButton.layer.masksToBounds = true
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(saveButton)
    }
    
    func setupConstraints() {
        bankCardImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(bankCardImageView.snp.width).multipliedBy(0.6)
        }
        
        balanceLabel?.snp.makeConstraints { make in
            make.top.equalTo(bankCardImageView.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel!.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(50) // Match the save button's height
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(amountTextField)
            make.height.equalTo(50)
        }
    }
    
    @objc func saveButtonTapped() {
        guard let amountText = amountTextField.text, !amountText.isEmpty, let amount = Double(amountText) else {
            let alert = UIAlertController(title: "Error", message: "Please enter a valid amount", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        print("Saved \(amount) to savings account")
        
        transferMoney(childId: childId ?? 0, money: Int(amount))
        
        amountTextField.text = ""
    }
    
    func fetchBalance(childId: Int) {
        NetworkManager.shared.getBalance(childId: childId) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.balance = data.balance
                    self.balanceLabel?.text = "💰 Balance: \(self.balance ?? 0) KWD"
                }
            case .failure(let error):
                print("Failed to fetch balance: \(error.localizedDescription)")
            }
        }
    }
    
    func transferMoney(childId: Int, money: Int) {
        NetworkManager.shared.transferMoney(childId: childId, transferMoney: money) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Success", message: "Amount saved successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    print("Success!")
                }
            case .failure(let error):
                print("Failed to fetch balance: \(error.localizedDescription)")
            }
        }
    }
}
