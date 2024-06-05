
import UIKit
import SnapKit


class BankCardViewController: UIViewController {
    

    let bankCardImageView = UIImageView()
    let amountTextField = UITextField()
    let saveButton = UIButton(type: .system)
    
    var balance: Decimal?
    var childId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        setupBankCardImageView()
        setupAmountTextField()
        setupSaveButton()
        setupConstraints()
        BalanceLabel()
       // fetchBalance(childId: childId)
    }
    
    func setupBankCardImageView() {
        // Set up the bank card image view
        bankCardImageView.image = UIImage(named: "saving") // Make sure the image name matches the actual image asset name
        bankCardImageView.contentMode = .scaleAspectFit
        view.addSubview(bankCardImageView)
    }
    
    func setupAmountTextField() {
        // Set up the amount text field
        amountTextField.placeholder = "Enter amount"
        amountTextField.borderStyle = .roundedRect
        amountTextField.keyboardType = .decimalPad
        view.addSubview(amountTextField)
    }
    private func BalanceLabel() -> UILabel {
        let balanceLabel = UILabel()
        balanceLabel.text = "Balance: \(balance)"
        balanceLabel.textColor = UIColor(red: 1.0, green: 0.796, blue: 0.486, alpha: 1.0)
        balanceLabel.font = UIFont.boldSystemFont(ofSize: 39)
        
        self.view.addSubview(balanceLabel)
        
        balanceLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.view).offset(150)
            make.top.equalTo(self.view).offset(190)
        }
        
        return balanceLabel
    }
    
    func setupSaveButton() {
        // Set up the save button
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = UIColor.systemYellow
        saveButton.layer.cornerRadius = 10
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(saveButton)
    }
    
    func setupConstraints() {
        // Use SnapKit to set up constraints
        bankCardImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(bankCardImageView.snp.width).multipliedBy(0.6) // Adjust the multiplier as needed
        }
        
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(bankCardImageView.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(amountTextField)
            make.height.equalTo(50)
        }
    }
    
    @objc func saveButtonTapped() {
        // Handle save button tap
        guard let amountText = amountTextField.text, !amountText.isEmpty, let amount = Double(amountText) else {
            // Show an alert if the amount is invalid
            let alert = UIAlertController(title: "Error", message: "Please enter a valid amount", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Implement the logic to save the amount to the savings account
        print("Saved \(amount) to savings account")
        
        // Show a confirmation alert
        let alert = UIAlertController(title: "Success", message: "Amount saved successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            // Dismiss the current view controller and return to the home page
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
        
        // Clear the text field
        amountTextField.text = ""
    }
    
//    func fetchBalance(childId: Int){
//        let token = "your_token_here" // replace with your actual token
//        NetworkManager.shared.getBalance(token: token, childId: childId) { result in
//            switch result {
//            case.success(let data):
//                self.balance = data.Balance
//                DispatchQueue.main.async {
//                    self.BalanceLabel()
//                }
//            case.failure(let error):
//                print("Failed to fetch balance: \(error.localizedDescription)")
//            }
//        }
//    }
}
