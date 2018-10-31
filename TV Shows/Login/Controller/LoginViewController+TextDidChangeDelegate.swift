import Foundation

extension LoginViewController: TextDidChangeDelegate{
    
    func textDidChange(onType: CustomTextFieldView.TextFieldMode, text: String) {
        if onType == .email {
            emailText = text
        } else {
            passwordText = text
        }

        loginButton.backgroundColor = (!passwordText.isEmpty && !emailText.isEmpty) ? .color(key: .buttonLogInEnabled) : .color(key: .buttonLogInDisabled)
    }
    
}
