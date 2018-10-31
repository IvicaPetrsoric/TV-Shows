import UIKit

class LoginViewController: UIViewController {
    
    let logoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "img-login-logo")?.withRenderingMode(.alwaysOriginal))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var emailText = ""
    var passwordText = ""
    
    lazy var emailTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.delegate = self
        textField.textFieldMode = .email
        return textField
    }()
    
    lazy var passwordTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.delegate = self
        textField.textFieldMode = .password
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
        logoImageView.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 88, left: 0, bottom: 0, right: 0), size: .init(width: 64, height: 64))
        logoImageView.anchorCenterXToSuperview()
        
        emailTextField.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 215, left: 0, bottom: 0, right: 0), size: .init(width: 375, height: 64))
        emailTextField.anchorCenterXToSuperview()
        
        passwordTextField.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 295, left: 0, bottom: 0, right: 0), size: .init(width: 375, height: 64))
        passwordTextField.anchorCenterXToSuperview()
    }
    
}









