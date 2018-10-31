import UIKit

class SaveUserCredentialView: BaseView {
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "ic-checkbox-empty")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSaveCredentials), for: .touchUpInside)
        return button
    }()
    
    let rememberMeLabel: UILabel = {
        let label = UILabel()
        label.text = "Remember me"
        label.textColor = .black
        return label
    }()
    
    var saveCredentials = false
    
    override func setupViews() {
        addSubview(checkButton)
        addSubview(rememberMeLabel)
        
        checkButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0), size: .init(width: 24, height: 24))
        rememberMeLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 17, left: 56, bottom: 0, right: 0), size: .init(width: 0, height: 22))
    }
    
    func shouldSaveCredentials() -> Bool {
        return saveCredentials
    }
    
    @objc func handleSaveCredentials() {
        saveCredentials = !saveCredentials
        
        let imageName = saveCredentials ? "ic-checkbox-filled" : "ic-checkbox-empty"
        checkButton.setBackgroundImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
}

