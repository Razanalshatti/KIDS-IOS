import UIKit

class ServiceTableViewCell: UITableViewCell {
    
    let serviceLabel = UILabel()
    let transferPtsToGold = UIButton(type: .system)


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
      
        transferPtsToGold.setTitleColor(.black, for: .normal)
        transferPtsToGold.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        transferPtsToGold.setBackgroundImage(UIImage(named: "GroupGreen3"), for: .normal)
        transferPtsToGold.layer.cornerRadius = 1
        transferPtsToGold.layer.masksToBounds = true
        addSubview(transferPtsToGold)

    }

    func setupConstraints() {
        // Transfer Points to Gold Button
        transferPtsToGold.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(69)
            
        }

    }


}
