import UIKit
import Alamofire

protocol LoginViewDelegate: class {
    func userLoged()
}

class LoginViewController: UIViewController {
    
    weak var delegate: LoginViewDelegate?
    
    let logoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "img-login-logo")?.withRenderingMode(.alwaysOriginal))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var userEmail = ""
    var userPassword = ""
    
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
    
    let saveUserCredentialView = SaveUserCredentialView()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOG IN", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .color(key: .pinkDisabled)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    fileprivate let progressIndicator = PrgoressIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        setupViews()
        loadCredentials()
    }
    
    fileprivate func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(saveUserCredentialView)
        view.addSubview(loginButton)
        view.addSubview(progressIndicator)
        
        logoImageView.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil,
                             padding: .init(top: 88, left: 0, bottom: 0, right: 0), size: .init(width: 64, height: 64))
        logoImageView.anchorCenterXToSuperview()
        
        emailTextField.anchor(top: logoImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,
                              padding: .init(top: 47, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 64))
        
        passwordTextField.anchor(top: emailTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,
                                 padding: .init(top: 16, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 64))
        
        saveUserCredentialView.anchor(top: passwordTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,
                                      padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 56))
        
        loginButton.anchor(top: saveUserCredentialView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,
                           padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 48))
        
        progressIndicator.fillSuperview()
    }
    
    @objc func handleLogin() {
        saveCredentials()
        resignFirstResponder()
        progressIndicator.animate(show: true)
        
        handleServiceLogIn()
    }
    
    fileprivate func handleServiceLogIn() {
        let parameters: Parameters = [
            "email": userEmail,
            "password": userPassword
        ]
        ServiceApi.shared.postData(parameters: parameters, endpoint: .login) { [weak self] (response) in
            self?.progressIndicator.animate(show: false)
            
            if response == .error {
                self?.showAllert(message: .errorLogin)
                return
            }
            
            self?.delegate?.userLoged()
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    func updateLoginButtonColor() {
        loginButton.backgroundColor = (!userPassword.isEmpty && !userEmail.isEmpty) ? .color(key: .pinkEnabled) : .color(key: .pinkDisabled)
        loginButton.isEnabled =  (!userPassword.isEmpty && !userEmail.isEmpty) ? true : false
    }
    
    fileprivate func saveCredentials() {
        let email = saveUserCredentialView.saveCredentials ? userEmail : ""
        let password = saveUserCredentialView.saveCredentials ? userPassword : ""

        UserDefaults.standard.set(email, forKey: UserDefaults.Keys.userEmail.rawValue)
        UserDefaults.standard.set(password, forKey: UserDefaults.Keys.userPasswprd.rawValue)
    }
    
    fileprivate func loadCredentials() {
        userEmail = UserDefaults.standard.string(forKey: UserDefaults.Keys.userEmail.rawValue) ?? ""
        userPassword = UserDefaults.standard.string(forKey: UserDefaults.Keys.userPasswprd.rawValue) ?? ""
        
        if !userEmail.isEmpty && !userPassword.isEmpty {
            emailTextField.updateTextField(text: userEmail)
            passwordTextField.updateTextField(text: userPassword)
            saveUserCredentialView.savedCredentials()
        }
        
        updateLoginButtonColor()
    }
    
}
