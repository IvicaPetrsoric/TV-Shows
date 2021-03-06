import UIKit

protocol TextDidChangeDelegate: class {
    func textDidChange(onType: CustomTextFieldView.TextFieldMode, text: String)
}

class CustomTextFieldView: BaseView {
    
    enum TextFieldMode {
        case email
        case password
    }
    
    var textFieldMode: TextFieldMode? {
        didSet {
            setupTextFieldViews()
        }
    }
    
    fileprivate var placeholderStartFont = UIFont.systemFont(ofSize: 15)
    fileprivate var placeholderEndFont = UIFont.systemFont(ofSize: 13)
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = .lightGray
        label.font = self.placeholderStartFont
        return label
    }()
    
    lazy var myTextField: UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    lazy var showPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "ic-hide-password")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleShowPasswrod), for: .touchUpInside)
        return button
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleDismisKeyboard))
        doneButton.tintColor = .color(key: .pinkEnabled)
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        return toolBar
    }()
    
    weak var delegate: TextDidChangeDelegate?
    
    var maximizedPlaceholderTopAnchorConstraint: NSLayoutConstraint!
    var minimizedPlaceholderTopAnchorConstraint: NSLayoutConstraint!
    
    func setupTextFieldViews() {
        addSubview(myTextField)
        addSubview(placeholderLabel)
        addSubview(borderView)
        
        if textFieldMode == .password {
            addSubview(showPasswordButton)
            showPasswordButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 28, left: 0, bottom: 0, right: 16), size: .init(width: 24, height: 24))
            myTextField.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: showPasswordButton.leadingAnchor, padding: .init(top: 28, left: 16, bottom: 0, right: 0), size: .init(width: 0, height: 22))
            myTextField.isSecureTextEntry = true
            placeholderLabel.text = "Password"
        } else {
            myTextField.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 28, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 22))
        }
        
        placeholderLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 18))
        maximizedPlaceholderTopAnchorConstraint = placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6)
        minimizedPlaceholderTopAnchorConstraint = placeholderLabel.topAnchor.constraint(equalTo: myTextField.topAnchor, constant: 4)
        minimizedPlaceholderTopAnchorConstraint.isActive = true
        borderView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 1, right: 16), size: .init(width: 0, height: 1))
        
        myTextField.inputAccessoryView = toolBar
    }
    
    func updateTextField(text: String) {
        myTextField.text = text
        movePlaceholderUp()
    }
    
    @objc func handleDismisKeyboard() {
        endEditing(true)
    }
    
    @objc func handleShowPasswrod() {
        myTextField.isSecureTextEntry = !myTextField.isSecureTextEntry
        let backgroundImage =  myTextField.isSecureTextEntry ?  "ic-hide-password" : "ic-characters-hide"
        showPasswordButton.setBackgroundImage(UIImage(named: backgroundImage)?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    @objc func handleTextInputChange() {
        let text = myTextField.text ?? ""
        if !(text).isEmpty {
            movePlaceholderUp()
        } else {
            movePlaceholderDown()
        }
        
        if let mode = textFieldMode {
            delegate?.textDidChange(onType: mode, text: text)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    fileprivate func movePlaceholderUp() {
        placeholderLabel.font = placeholderEndFont
        minimizedPlaceholderTopAnchorConstraint.isActive = false
        maximizedPlaceholderTopAnchorConstraint.isActive = true
    }
    
    fileprivate func movePlaceholderDown() {
        placeholderLabel.font = placeholderStartFont
        maximizedPlaceholderTopAnchorConstraint.isActive = false
        minimizedPlaceholderTopAnchorConstraint.isActive = true
    }
    
}
